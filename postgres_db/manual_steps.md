# storing passwords

Manually create a secret which can be used in values.yaml config file.
The user and password are stored in Bitwarden under "kuberenetes_home - PostgresDB"

kubectl create secret generic postgres-password --from-literal=postgresql-password=my_postgres_password -n your_namespace
