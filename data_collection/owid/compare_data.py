import os
from sqlalchemy import create_engine, text
import subprocess
import shlex
import sys

CONFIG_PATH = ".."
sys.path.insert(0, CONFIG_PATH)
from config import OWID_HOST, OWID_CSV_PATH, OWID_FILENAME, DB_URI
from loguru import logger

logger.add("/var/log/owid_fetch.log", retention="7 days")


def database_size(remote=True):
    if remote:
        proc = subprocess.Popen(
            shlex.split(f"ssh -f epigraph@{OWID_HOST} -L 5432:localhost:5432 -NC")
        )
    try:
        engine = create_engine(DB_URI)
        with engine.connect().execution_options(autocommit=True) as conn:
            curr = conn.execute(text("SELECT COUNT(*) FROM owid_covid"))
            for count in curr:
                return int(count[0])
    except Exception as e:
        logger.error(f"Could not access OWID table\n{e}")
        raise (e)
    finally:
        if remote:
            proc.kill()


def csv_size():
    raw_shape = subprocess.Popen(
        f"wc -l {os.path.join(OWID_CSV_PATH, OWID_FILENAME)}",
        shell=True,
        stdout=subprocess.PIPE,
    ).stdout
    clean = str(raw_shape.read()).split("'")
    shape = clean[1].split(" ")[0]
    return int(shape) - 1
