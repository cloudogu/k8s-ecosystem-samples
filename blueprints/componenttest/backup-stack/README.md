# Config test execution

- Run `run_local_minio.sh` to start a local Minio.
- Run `create_backup_secrets.sh` to create secrets for longhorn and velero.
- Configure Minio
  - Navigate `http://localhost:9000`
  - Credentials `admin123:admin123`
  - Create access keys
    - Name: `MY-ACCESS-KEY` Secret: `MY-ACCESS-SECRET123`
    - Name: `MY-VELERO-ACCESS-KEY` Secret: `MY-VELERO.ACCESS-SECRET123`
  - Create buckets
    - `longhorn`
    - `velero`
- Apply backup stack with component configuration
  - `kubectl apply -f k8s_v1_blueprint_configure_backup.yaml --namespace=ecosystem`
- Create a backup
  - `kubectl apply -f ../../../../backups/backup.yaml --namespace=ecosystem`