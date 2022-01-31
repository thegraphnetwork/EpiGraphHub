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


def load_into_db(client):
    # count the total number of records in the dataframe
    records = client.get_all("gt2j-8ykr", select = 'COUNT(*)')
    for i in records:
        record_count = i
        break
    
    # start the looping to get the data in chunks of 10000 rows 
    start = 0             # Start at 0
    chunk_size = 10000     # Fetch 10000 rows at a time
    
    '''
    date that separate the data that will be ignored and the data that will be 
    updated in the param if_row_exists of the function upsert
    (only will be updated the data related with the last 3 months)
    '''
    
    today = datetime.date(datetime.today())
    days_ago = timedelta(90)
    slice_date = today - days_ago
    slice_date = slice_date.strftime('%Y-%m-%d')
    
    
    while True:
        # Fetch the set of records starting at 'start'
        results =  client.get("gt2j-8ykr", offset=start, limit=chunk_size) 
        
        # create a df with this chunk files
        df_new = pd.DataFrame.from_records(results)
        df_new.index.name = 'id_'
        
        df_new = df_new.convert_dtypes()
        
        # transform the datetime columns in the correct time 
        df_new['fecha_reporte_web'] = pd.to_datetime(df_new['fecha_reporte_web'], errors='coerce')
        df_new['fecha_de_notificaci_n'] = pd.to_datetime(df_new['fecha_de_notificaci_n'], errors='coerce')
        
        # separate the part of the df that will be set as `ignore` and `update` in the if_row_exists params. 
        df_new1 = df_new.loc[df_new['fecha_reporte_web'] <= slice_date]
        df_new2 = df_new.loc[df_new['fecha_reporte_web'] > slice_date] 
        
        del df_new 
        
        # put the data into the bank
        engine = create_engine('postgresql://epigraph:epigraph@localhost:5432/epigraphhub')
        with engine.connect() as conn:
            upsert(con=conn, df = df_new1, table_name='casos_positivos_covid', schema='colombia', if_row_exists='ignore',
                chunksize=1000, add_new_columns=True, create_table=True) 
            
        with engine.connect() as conn:
            upsert(con=conn, df = df_new2, table_name='casos_positivos_covid', schema='colombia', if_row_exists='update',
                chunksize=1000, add_new_columns=True, create_table=True) 
            
        del df_new1
        del df_new2
    
        # Move up the starting record
        start = start + chunk_size
        # If we have fetched all of the records, bail out
        if (start > int(record_count['COUNT'])):
            break
        
        #break
        
if __name__ == "__main__":
    start_time = time.time()
    load_into_db(client)
    print("--- %s seconds ---" % (time.time() - start_time))
