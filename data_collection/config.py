import os
from pathlib import Path
from sodapy import Socrata
from dotenv import load_dotenv

project_path = Path(__file__).resolve().parent
load_dotenv(project_path / ".env")

DB_HOST = os.environ.get("POSTGRES_HOST")
DB_PORT = os.environ.get("POSTGRES_PORT")
DB_USER = os.environ.get("POSTGRES_USER")
DB_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
DB_NAME = os.environ.get("POSTGRES_DB")
DB_NAME_PRIVATE = os.environ.get("POSTGRES_DB_PRIVATE")

DB_URI = f"postgresql://{DB_USER}:{DB_PASSWORD}" f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
DB_URI_PRIVATE = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME_PRIVATE}"
)

# Owid

OWID_CSV_URL = "https://covid.ourworldindata.org/data/owid-covid-data.csv"
OWID_CSV_PATH = "/tmp/owid/releases"
OWID_FILENAME = OWID_CSV_URL.split("/")[-1]
OWID_HOST = "135.181.41.20"

# Colombia

COLOMBIA_SOC = Socrata("www.datos.gov.co", "078u4PCGpnDfH157kAkVFoWea")

# foph

FOPH_URL = "https://www.covid19.admin.ch/api/data/context"
FOPH_CSV_PATH = "/tmp/foph/releases"
