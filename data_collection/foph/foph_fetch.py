import pandas as pd
from pangres import upsert
from sqlalchemy import create_engine, text, VARCHAR
import subprocess
import os
from loguru import logger

from config import FOPH_CSV_PATH, DB_URI

logger.add("/var/log/foph_fetch.log", retention="7 days")


def csv_size(filename):
    raw_shape = subprocess.Popen(
        f"wc -l {os.path.join(FOPH_CSV_PATH, filename)}",
        shell=True,
        stdout=subprocess.PIPE,
    ).stdout
    clean = str(raw_shape.read()).split("'")
    shape = clean[1].split(" ")[0]
    return int(shape)


def table_size(table):
    engine = create_engine(DB_URI)
    try:
        with engine.connect().execution_options(autocommit=True) as conn:
            curr = conn.execute(
                text(f"SELECT COUNT(*) FROM switzerland.foph_{table.lower()}_d")
            )
            for count in curr:
                return int(count[0])
    except Exception as e:
        logger.error(f"Could not access {table} table\n{e}")
        raise (e)


def load_into_db(table, filename):
    new_df = pd.read_csv(f"{FOPH_CSV_PATH}/{filename}")
    logger.info(f"Reading {filename}")

    new_df = new_df.rename(columns=str.lower)
    new_df.index.name = "id_"
    if not "date" in new_df.columns:
        new_df["date"] = pd.to_datetime(new_df.datum)
    else:
        new_df["date"] = pd.to_datetime(new_df.date)
    logger.info(f"Table {table} passed to DataFrame")

    engine = create_engine(DB_URI)
    with engine.connect() as conn:
        upsert(
            con=conn,
            df=new_df,
            table_name=f"foph_{table.lower()}_d",
            schema="switzerland",
            if_row_exists="update",
            chunksize=1000,
            add_new_columns=True,
            create_table=True,
        )
    logger.info(f"Table {table} updated")

    with engine.connect() as connection:
        try:
            connection.execute(
                f'CREATE INDEX IF NOT EXISTS region_idx  ON switzerland.foph_{table.lower()} ("geoRegion");'
            )
        except Exception as e:
            logger.info(f"Could not create region index: {e}")
        try:
            connection.execute(
                f"CREATE INDEX IF NOT EXISTS date_idx ON switzerland.foph_{table.lower()} (date);"
            )
        except Exception as e:
            logger.info(f"Could not create date index: {e}")
