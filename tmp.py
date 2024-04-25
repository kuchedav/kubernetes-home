# python -m pip install pip polars sqlalchemy psycopg2 daves_utilities --upgrade
# python

import polars as pl
from sqlalchemy.engine import create_engine, URL
from daves_utilities.david_secrets import get_credentials
from urllib.parse import quote

# Get the credentials
crd = get_credentials("postgres")

# Create the URL object
# url = URL(
#     drivername='postgresql',
#     username=crd["usr"],
#     password=crd["pwd"],
#     host='localhost', # david-postgres-postgresql.default.svc.cluster.local
#     port='5432',
#     database='postgres',
# )


# URL encode the username and password
username = quote(crd['usr'])
password = quote(crd['pwd'])
connection_string = f"postgresql://{username}:{password}@david-postgres-postgresql.default.svc.cluster.local:5432/postgres"

# Create the engine
engine = create_engine(connection_string)

query = "SELECT * FROM public.sepia"
pl.read_database(query=query, connection=engine)
