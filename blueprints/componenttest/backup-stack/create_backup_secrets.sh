#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

kubectl create secret generic longhorn-backup-target --namespace=longhorn-system \
--from-literal=AWS_ENDPOINTS=http://192.168.56.1:9000 \
--from-literal=AWS_ACCESS_KEY_ID=MY-ACCESS-KEY \
--from-literal=AWS_SECRET_ACCESS_KEY=MY-ACCESS-SECRET123

kubectl apply --namespace=ecosystem -f - <<EOF
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: velero-backup-target
stringData:
  cloud: |
    [default]
    aws_access_key_id=MY-VELERO-ACCESS-KEY
    aws_secret_access_key=MY-VELERO.ACCESS-SECRET123
EOF
