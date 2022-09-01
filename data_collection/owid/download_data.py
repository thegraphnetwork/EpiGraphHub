import os
import subprocess
from config import OWID_CSV_PATH, OWID_CSV_URL, OWID_FILENAME
from loguru import logger

logger.add("/var/log/owid_fetch.log", retention="7 days")

def download_csv():
    os.makedirs(OWID_CSV_PATH, exist_ok=True)
    subprocess.run(['curl', '--silent', '-f', '-o', f'{OWID_CSV_PATH}/{OWID_FILENAME}', f'{OWID_CSV_URL}'])
    logger.warning("OWID csv downloaded.")

def remove_csv():
    os.remove(f'{OWID_CSV_PATH}/{OWID_FILENAME}')
    logger.warning("OWID csv removed.")

