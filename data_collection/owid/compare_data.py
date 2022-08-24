import os
from sqlalchemy import create_engine, text
import subprocess
import shlex
import sys; CONFIG_PATH = ".."
sys.path.insert(0, CONFIG_PATH)
from config import HOST, DATA_PATH, FILENAME, DB_URI


# import logging
# from logging.handlers import RotatingFileHandler


# logger = logging.getLogger("owid_fetch")
# fh = RotatingFileHandler('/var/log/owid_fetch.log', maxBytes=2000, backupCount=5)
# logger.setLevel(logging.DEBUG)
# formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
# fh.setFormatter(formatter)
# logger.addHandler(fh)

def database_size(remote=True):
    if remote:
        proc = subprocess.Popen(shlex.split(f'ssh -f epigraph@{HOST} -L 5432:localhost:5432 -NC'))
    try:
        engine = create_engine(DB_URI)   
        with engine.connect().execution_options(autocommit=True) as conn:
            curr = conn.execute(text("SELECT COUNT(*) FROM owid_covid"))
            for count in curr:
                return int(count[0])
    except Exception as e:
        # logger.error(f"Could not access OWID table\n{e}")
        raise(e)
    finally:
        if remote:
            proc.kill()             

def csv_size():
    raw_shape = subprocess.Popen(f'wc -l {os.path.join(DATA_PATH, FILENAME)}', shell=True, stdout=subprocess.PIPE).stdout
    clean = str(raw_shape.read()).split("'")
    shape = clean[1].split(' ')[0]
    return int(shape)
