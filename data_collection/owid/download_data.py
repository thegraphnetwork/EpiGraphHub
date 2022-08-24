import os
import subprocess
from config import DATA_PATH, OWID_URL, FILENAME

# import logging
# from logging.handlers import RotatingFileHandler

# logger = logging.getLogger("owid_fetch")
# fh = RotatingFileHandler('/var/log/owid_fetch.log', maxBytes=2000, backupCount=5)
# logger.setLevel(logging.DEBUG)
# formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
# fh.setFormatter(formatter)
# logger.addHandler(fh)

def download_csv():
    os.makedirs(DATA_PATH, exist_ok=True)
    subprocess.run(['curl', '--silent', '-f', '-o', f'{DATA_PATH}/{FILENAME}', f'{OWID_URL}'])
    # logger.warning("OWID csv downloaded.")
