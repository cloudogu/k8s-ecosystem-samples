#!/usr/bin/env bash

set -euo pipefail

YQ_BIN="${YQ_BIN:-./.bin/yq}"
CURL_BIN="${CURL_BIN:-curl}"
MAPPING_FILE="${MAPPING_FILE:-./scripts/repo-mapping.txt}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

if [ -n "$GITHUB_TOKEN" ]; then
  AUTH_HEADER="Authorization: Bearer $GITHUB_TOKEN"
else
  AUTH_HEADER=""
fi

resolve_repo_name() {
  local COMPONENT="$1"
  local REPO_NAME="$COMPONENT"

  if [ -f "$MAPPING_FILE" ]; then
    while IFS='=' read -r MAP_COMPONENT MAP_REPO || [ -n "${MAP_COMPONENT:-}" ]; do
      [ -z "${MAP_COMPONENT:-}" ] && continue

      case "$MAP_COMPONENT" in
        \#*)
          continue
          ;;
      esac

      if [ "$MAP_COMPONENT" = "$COMPONENT" ]; then
        REPO_NAME="$MAP_REPO"
        break
      fi
    done < "$MAPPING_FILE"
  fi

  echo "$REPO_NAME"
}

printf "%-40s %-40s %-20s %-20s\n" \
  "COMPONENT" "REPOSITORY" "CURRENT" "LATEST"

find components dogus \
  -type f \( -name '*.yaml' -o -name '*.yml' \) |
sort |
while read -r YAML_FILE; do

  COMPONENT=$($YQ_BIN eval '.spec.name' "$YAML_FILE" 2>/dev/null)

  [ -z "$COMPONENT" ] && continue
  [ "$COMPONENT" = "null" ] && continue
  COMPONENT="${COMPONENT##*/}"

  CURRENT_VERSION=$($YQ_BIN eval '.spec.version' "$YAML_FILE" 2>/dev/null)
  CURRENT_VERSION="${CURRENT_VERSION#v}"

  REPO_NAME=$(resolve_repo_name "$COMPONENT")

  RESPONSE=$(
    $CURL_BIN -s \
      -H "Accept: application/vnd.github+json" \
      -H "User-Agent: update-versions-script" \
      ${AUTH_HEADER:+-H "$AUTH_HEADER"} \
      "https://api.github.com/repos/cloudogu/${REPO_NAME}/releases/latest" \
      || true
  )

  LATEST_VERSION=$(
    printf '%s' "$RESPONSE" |
    $YQ_BIN eval '.tag_name // "n/a"' - 2>/dev/null ||
    echo "n/a"
  )
  LATEST_VERSION="${LATEST_VERSION#v}"

  printf "%-40s %-40s %-20s %-20s\n" \
    "$COMPONENT" \
    "$REPO_NAME" \
    "$CURRENT_VERSION" \
    "$LATEST_VERSION"

  if [ "$LATEST_VERSION" != "n/a" ] && [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo "Updating $YAML_FILE: $CURRENT_VERSION -> $LATEST_VERSION"

    $YQ_BIN eval -i \
      ".spec.version = \"$LATEST_VERSION\"" \
      "$YAML_FILE"
  fi

done