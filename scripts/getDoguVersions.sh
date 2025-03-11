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
  echo "Please provide a <NAMESPACE/DOGU> as argument"
  exit 1
fi

# Check if required environment variables are set
if [ -z "$DCC_USERNAME" ] || [ -z "$DCC_BASE64_PASSWORD" ]; then
  echo "Error: DCC_BASE64_PASSWORD is not set in .env file."
  exit 1
fi

# Decode the base64-encoded password
DECODED_PASSWORD=$(echo "$DCC_BASE64_PASSWORD" | base64 --decode)

getDoguVersions() {
  # Define the base URL and dynamic part
  BASE_URL="https://dogu.cloudogu.com/api/v2/dogus/"
  DYNAMIC_PART="$1"
  FULL_URL="${BASE_URL}${DYNAMIC_PART}/_versions"

  AUTH_HEADER="Authorization: Basic $(echo -n "$DCC_USERNAME:$DECODED_PASSWORD" | base64)"
  curl -s -X GET "$FULL_URL" -H "$AUTH_HEADER" | jq '.[0:10]'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  getDoguVersions "$@"
fi