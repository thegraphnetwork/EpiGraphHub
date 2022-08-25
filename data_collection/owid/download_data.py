import os
import subprocess
from config import DATA_PATH, OWID_URL, FILENAME
from logger import Logger

logger = Logger.generate_log('owid_fetch', '/var/log/owid_fetch.log')

def download_csv():
    os.makedirs(DATA_PATH, exist_ok=True)
    subprocess.run(['curl', '--silent', '-f', '-o', f'{DATA_PATH}/{FILENAME}', f'{OWID_URL}'])
    logger.warning("OWID csv downloaded.")

def remove_csv():
    os.remove(f'{DATA_PATH}/{FILENAME}')
    logger.warning("OWID csv removed.")

