# storing passwords

Manually create a secret which can be used in values.yaml config file.
The user and password are stored in Bitwarden under "kuberenetes_home - PostgresDB"

kubectl create secret generic david-postgresdb --from-literal=david-postgresdb=<PWD>

# Postgres useful output information

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    david-postgres-postgresql.default.svc.cluster.local - Read/Write connection
