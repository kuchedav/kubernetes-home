
########################################################################################
# POSTGRES                                                                             #
########################################################################################

#!Make sure to create the secret with the password before running the following commands
pg_create_secret:
	kubectl create secret generic david-postgresdb --from-literal=david-postgresdb=<PWD>

pg_export_password:
	-export POSTGRES_PASSWORD=$(kubectl get secret --namespace default \
		david-postgres-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

# create the david_postgres user
pg_create_user: pg_export_password
	python ./postgres_db/setup_user.py

# load in some small demo data set to postgres
pg_load_demo_data: pg_export_password
	# Copy the SQL script to the PostgreSQL pod
	kubectl cp ./postgres_db/demo_data.sql \
		default/david-postgres-postgresql-0:/tmp/demo_data.sql

	# Execute the SQL script with psql
	kubectl exec david-postgres-postgresql-0 -- bash \
		-c 'PGPASSWORD=$(POSTGRES_PASSWORD) psql -U postgres \
		-d postgres -f /tmp/demo_data.sql'

# To connect to your database from outside the cluster execute the following commands
pg_activate_outside_connections: pg_export_password
	kubectl port-forward --namespace default svc/david-postgres-postgresql 5432:5432 \
	& PGPASSWORD="$(POSTGRES_PASSWORD)" psql --host 127.0.0.1 -U postgres \
	-d postgres -p 5432

# To connect to your database run the following command
pg_connect: pg_export_password
	kubectl run david-postgres-postgresql-client --rm --tty -i --restart='Never' \
		--namespace default --image docker.io/bitnami/postgresql:16.2.0-debian-12-r15 \
		--env="PGPASSWORD=$(POSTGRES_PASSWORD)" --command -- psql \
		--host david-postgres-postgresql -U postgres -d postgres -p 5432

# Install the postgres database
pg_install: pg_create_secret pg_export_password pg_create_user pg_load_demo_data
	-helm repo add bitnami https://charts.bitnami.com/bitnami
	-helm repo update
	helm install david-postgres -f postgres_db/values.yaml bitnami/postgresql

pg_uninstall:
	helm uninstall david-postgres

########################################################################################
# DEBUG-POD                                                                            #
########################################################################################

# Busybox is a great tool for debugging, just enter the pod and start poking around

debug_start:
	kubectl apply -f ./debug/debug-pod.yaml

debug_enter:
	kubectl exec -it debug-pod -- /bin/sh

debug_stop:
	kubectl delete -f ./debug/debug-pod.yaml

########################################################################################
