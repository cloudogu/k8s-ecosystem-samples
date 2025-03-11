#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Load environment variables from the .env file in the script's directory
if [ -f "$SCRIPT_DIR/.env" ]; then
  source "$SCRIPT_DIR/.env"
else
  echo ".env file not found in $SCRIPT_DIR!"
  exit 1
fi

# Check if the last part of the URL is provided
if [ -z "$1" ]; then
  echo "Please provide a <COMPONENT> as argument"
  exit 1
fi

# Check if required environment variables are set
if [ -z "$REGISTRY_USERNAME" ] || [ -z "$REGISTRY_BASE64_PASSWORD" ]; then
  echo "Error: REGISTRY_BASE64_PASSWORD is not set in .env file."
  exit 1
fi

# Decode the base64-encoded password
DECODED_PASSWORD=$(echo "$REGISTRY_BASE64_PASSWORD" | base64 --decode)

getComponentVersions() {
  # Define the base URL and dynamic part
  BASE_URL="https://registry.cloudogu.com/api/v2.0/projects/k8s/repositories/"
  DYNAMIC_PART="$1"
  FULL_URL="${BASE_URL}${DYNAMIC_PART}/artifacts"

  AUTH_HEADER="Authorization: Basic $(echo -n "$REGISTRY_USERNAME:$DECODED_PASSWORD" | base64)"
  curl -s -X GET "$FULL_URL" -H "$AUTH_HEADER" | jq '[.[] | .extra_attrs.version] | .[:10]'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  getComponentVersions "$@"
fi