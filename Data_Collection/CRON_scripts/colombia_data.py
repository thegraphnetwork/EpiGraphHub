#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 31 08:53:59 2022

@author: eduardoaraujo
"""

import time
import pandas as pd
from pangres import upsert
from sqlalchemy import create_engine
from datetime import datetime, timedelta
#from loguru import logger
from sodapy import Socrata

client = Socrata("www.datos.gov.co", '078u4PCGpnDfH157kAkVFoWea')

def chunked_fetch(start, chunk_size, maxrecords):
    
    slice_date = datetime.date(datetime.today()) - timedelta(200)

    slice_date = slice_date.strftime('%Y-%m-%d')
    
    # start the looping to get the data in chunks of 10000 rows 
    start = 0             # Start at 0
    chunk_size = 10000     # Fetch 10000 rows at a time
        
    while start < maxrecords:
        
        # Fetch the set of records starting at 'start'
        # create a df with this chunk files
        df_new = pd.DataFrame.from_records(client.get("gt2j-8ykr", offset=start, limit=chunk_size,
                                    order = 'fecha_reporte_web', where = f'fecha_reporte_web > "{slice_date}"'))
        df_new.index.name = 'id_'
        
        df_new = df_new.convert_dtypes()
        
        # transform the datetime columns in the correct time 
        df_new['fecha_reporte_web'] = pd.to_datetime(df_new['fecha_reporte_web'], errors='coerce')
        df_new['fecha_de_notificaci_n'] = pd.to_datetime(df_new['fecha_de_notificaci_n'], errors='coerce')
        
        # Move up the starting record
        start = start + chunk_size
        
        yield df_new
        

def load_into_db(client):
    # count the total number of records in the dataframe
    records = client.get_all("gt2j-8ykr", select = 'COUNT(*)')
    for i in records:
        record_count = i
        break
    
    del records
    
    start = 0
    chunk_size = 10000
    maxrecords = int(record_count['COUNT'])
    
    for df_new in chunked_fetch(start, chunk_size, maxrecords):
        # separate the part of the df that will be set as `ignore` and `update` in the if_row_exists params.
 
        # put the data into the bank
        engine = create_engine('postgresql://epigraph:epigraph@localhost:5432/epigraphhub')
        with engine.connect() as conn:
            upsert(con=conn, df = df_new, table_name='casos_positivos_covid', schema='colombia', if_row_exists= 'update',
                chunksize=1000, add_new_columns=True, create_table=True) 
            
        
if __name__ == "__main__":
    start_time = time.time()
    load_into_db(client)
    print("--- %s seconds ---" % (time.time() - start_time))
