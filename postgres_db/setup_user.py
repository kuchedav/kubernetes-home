import os
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from daves_utilities.david_secrets import get_credentials
from urllib.parse import quote

# Get the credentials
crd = get_credentials("postgres")

# Define the connection parameters
host = 'localhost'
port = '5432'
user = 'postgres'
password = os.getenv("POSTGRES_PASSWORD", default=None)

# Connect to the PostgreSQL server
conn = psycopg2.connect(host=host, port=port, user=user, password=password)

# Set the isolation level to AUTOCOMMIT
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

# Create a cursor object
cur = conn.cursor()

# Define the new user's name and password
new_user = quote(crd['usr'])
new_password = quote(crd['pwd'])

# Execute the CREATE USER command
try:
    cur.execute(f"CREATE USER {new_user} WITH PASSWORD '{new_password}';")
    conn.commit()
    print(f"User {new_user} created.")
except:
    print(f"User {new_user} already exists.")

try:
    cur.execute("GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE sepia TO PUBLIC;")
    conn.commit()
    print("Permissions granted.")
except:
    print("Permissions already granted.")

# Close the cursor and the connection
cur.close()
conn.close()
