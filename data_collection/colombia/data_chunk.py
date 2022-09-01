"""
Created on Mon Jan 31 08:53:59 2022

@author: eduardoaraujo
"""

import pandas as pd
from datetime import datetime, timedelta
from loguru import logger
from config import COLOMBIA_SOC

logger.add("/var/log/colombia_pos.log", retention="7 days")
client = COLOMBIA_SOC


class DFChunkGenerator:
    def chunked_fetch(start, chunk_size, maxrecords):

        slice_date = datetime.date(datetime.today()) - timedelta(200)

        slice_date = slice_date.strftime("%Y-%m-%d")

        # start the looping to get the data in chunks of 10000 rows
        start = 0  # Start at 0
        chunk_size = 10000  # Fetch 10000 rows at a time

        while start < maxrecords:

            # Fetch the set of records starting at 'start'
            # create a df with this chunk files
            df_new = pd.DataFrame.from_records(
                client.get(
                    "gt2j-8ykr",
                    offset=start,
                    limit=chunk_size,
                    order="fecha_reporte_web",
                    where=f'fecha_reporte_web > "{slice_date}"',
                )
            )

            df_new = df_new.rename(columns=str.lower)

            if df_new.empty:
                break

            df_new.set_index(["id_de_caso"], inplace=True)

            df_new = df_new.convert_dtypes()

            # change some strings to a standard
            df_new.replace(
                to_replace={
                    "ubicacion": {"casa": "Casa", "CASA": "Casa"},
                    "estado": {"leve": "Leve", "LEVE": "Leve"},
                    "sexo": {"f": "F", "m": "M"},
                },
                inplace=True,
            )

            # transform the datetime columns in the correct time
            for c in df_new.columns:
                if c.lower().startswith("fecha"):
                    df_new[c] = pd.to_datetime(df_new[c], errors="coerce")

            # eliminate any space in the end and start of the string values
            for i in df_new.select_dtypes(include=["string"]).columns:
                df_new[i] = df_new[i].str.strip()

            # Move up the starting record
            start = start + chunk_size

            yield df_new
