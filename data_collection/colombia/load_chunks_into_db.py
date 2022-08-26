"""
Created on Mon Jan 31 08:53:59 2022

@author: eduardoaraujo
"""

from pangres import upsert
from sqlalchemy import create_engine
from datetime import datetime, timedelta
from loguru import logger
from config import DB_URI
from .data_chunk import DFChunkGenerator as gen


def gen_chunks_into_db(client):

    slice_date = datetime.date(datetime.today()) - timedelta(200)
    slice_date = slice_date.strftime("%Y-%m-%d")

    # count the number of records that will be fetched
    records = client.get_all(
        "gt2j-8ykr", select="COUNT(*)", where=f'fecha_reporte_web > "{slice_date}"'
    )

    for i in records:
        record_count = i
        break

    del records

    start = 0
    chunk_size = 10000
    maxrecords = int(record_count["COUNT"])

    engine = create_engine(DB_URI)

    for df_new in gen.chunked_fetch(start, chunk_size, maxrecords):

        # save the data
        with engine.connect() as conn:
            upsert(
                con=conn,
                df=df_new,
                table_name="positive_cases_covid_d",
                schema="colombia",
                if_row_exists="update",
                chunksize=1000,
                add_new_columns=True,
                create_table=False,
            )

    logger.info("table casos_positivos_covid updated")
