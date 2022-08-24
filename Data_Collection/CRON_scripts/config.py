import os
from pathlib import Path

from dotenv import load_dotenv

project_path = Path(__file__).resolve().parent.parent.parent
load_dotenv(project_path / ".env")

DB_HOST = os.environ.get("POSTGRES_HOST")
DB_PORT = os.environ.get("POSTGRES_PORT")
DB_USER = os.environ.get("POSTGRES_EPIGRAPH_USER")
DB_PASSWORD = os.environ.get("POSTGRES_EPIGRAPH_PASSWORD")
DB_NAME = os.environ.get("POSTGRES_EPIGRAPH_DB")
DB_NAME_PRIVATE = os.environ.get("POSTGRES_EPIGRAPH_DB_PRIVATE")

DB_URI = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)
DB_URI_PRIVATE = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME_PRIVATE}"
)
