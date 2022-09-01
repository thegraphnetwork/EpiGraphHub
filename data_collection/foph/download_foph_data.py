import os
import requests
import subprocess
from loguru import logger
from config import FOPH_CSV_PATH, FOPH_URL

logger.add("/var/log/foph_fetch.log", retention="7 days")


def get_csv_relation(source=FOPH_URL):
    context = requests.get(source).json()
    tables = context["sources"]["individual"]["csv"]["daily"]
    for table, url in tables.items():
        yield table, url


def download_csv(url):
    os.makedirs(FOPH_CSV_PATH, exist_ok=True)
    filename = url.split("/")[-1]
    subprocess.run(["curl", "--silent", "-f", "-o", f"{FOPH_CSV_PATH}/{filename}", url])
    logger.info(f"{filename} downloaded at {FOPH_CSV_PATH}")
