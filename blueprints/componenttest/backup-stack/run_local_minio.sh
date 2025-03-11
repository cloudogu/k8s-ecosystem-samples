#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

docker run -d --name minio -p 9000:9000 -p 9090:9090 -e "MINIO_ROOT_USER=admin123" -e "MINIO_ROOT_PASSWORD=admin123" quay.io/minio/minio server /data --console-address ":9090"