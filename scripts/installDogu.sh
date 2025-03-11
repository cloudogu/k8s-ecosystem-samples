#!/bin/bash
# Get the directory where the current script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source the helper.sh script from the same directory
source "$SCRIPT_DIR/getDoguVersions.sh"

VERSION=$(getDoguVersions "$1" | jq '.[0]')
mkdir -p "$SCRIPT_DIR/target"

IFS='/' read -r NAMESPACE NAME <<< "$1"
sed "s|NAMESPACE|$NAMESPACE|g" "$SCRIPT_DIR/resources/k8s-dogu.tpl" | sed "s|NAME|$NAME|g" | sed "s|VERSION|$VERSION|g" > "$SCRIPT_DIR/target/installDogu.yaml";

kubectl apply -f "$SCRIPT_DIR/target/installDogu.yaml" --namespace=ecosystem