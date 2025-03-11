#!/bin/bash
# Get the directory where the current script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source the helper.sh script from the same directory
source "$SCRIPT_DIR/getComponentVersions.sh"

VERSION=$(getComponentVersions "$1" | jq '.[0]')
mkdir -p "$SCRIPT_DIR/target"
sed "s|NAME|$1|g" "$SCRIPT_DIR/resources/k8s-component.tpl" | sed "s|VERSION|$VERSION|g" > "$SCRIPT_DIR/target/installComponent.yaml";

kubectl apply -f "$SCRIPT_DIR/target/installComponent.yaml" --namespace=ecosystem