from sqlalchemy import create_engine
import pandas as pd
import os
import shlex
import subprocess
from config import DB_URI, OWID_HOST, OWID_CSV_PATH, OWID_FILENAME
from loguru import logger

logger.add("/var/log/owid_fetch.log", retention="7 days")


def parse_types(df):
    df = df.convert_dtypes()
    df["date"] = pd.to_datetime(df.date)
    logger.warning("OWID data types parsed.")
    return df


def load(remote=True):
    if remote:
        proc = subprocess.Popen(
            shlex.split(f"ssh -f epigraph@{OWID_HOST} -L 5432:localhost:5432 -NC")
        )
    try:
        data = pd.read_csv(os.path.join(OWID_CSV_PATH, OWID_FILENAME))
        data = parse_types(data)
        engine = create_engine(DB_URI)
        data.to_sql(
            "owid_covid",
            engine,
            index=False,
            if_exists="replace",
            method="multi",
            chunksize=10000,
        )
        logger.warning("OWID data inserted into database")
        with engine.connect() as connection:
            connection.execute(
                "CREATE INDEX IF NOT EXISTS country_idx  ON owid_covid (location);"
            )
            connection.execute(
                "CREATE INDEX IF NOT EXISTS iso_idx  ON owid_covid (iso_code);"
            )
            connection.execute(
                "CREATE INDEX IF NOT EXISTS date_idx ON owid_covid (date);"
            )
        logger.warning("Database indices created on OWID table")
    except Exception as e:
        logger.error(f"Could not update OWID table\n{e}")
        raise (e)
    finally:
        if remote:
            proc.kill()
