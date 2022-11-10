import os
from dotenv import load_dotenv
load_dotenv('.env')

PATH = 'saved_models'

POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_PORT = os.getenv("POSTGRES_PORT")
POSTGRES_DB = os.getenv("POSTGRES_DB")

DB_URI = (
     f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}"
     f"@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"
)