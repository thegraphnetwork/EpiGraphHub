
import os 
import pandas as pd
from pangres import upsert
from sqlalchemy import create_engine
import config
import wget
from loguru import logger 


def load_into_db(table_name, url, engine, log=True):
    
    wget.download(url, out=f'/tmp/temp_{table_name}.csv')
    
    chunksize = 10**4
    with pd.read_csv(f'/tmp/temp_{table_name}.csv', chunksize = chunksize) as reader:
        
        first = True
        for new_df in reader:

            if first == True:
                new_df = new_df.rename(columns = str.lower)
                new_df.index.name = 'id_'
                if 'date' in new_df.columns:
                    new_df['date'] = pd.to_datetime(new_df.date, errors = 'coerce')
                    new_df = new_df.dropna(subset = 'date')
                    
                new_df.to_sql(table_name, engine, schema='google_health', if_exists='replace')
                first = False
                
            else: 

                new_df = new_df.rename(columns = str.lower)
                new_df.index.name = 'id_'
                if 'date' in new_df.columns:
                    new_df['date'] = pd.to_datetime(new_df.date, errors = 'coerce')
                    new_df = new_df.dropna(subset = 'date')
                    
                new_df.to_sql(table_name, engine, schema='google_health', if_exists='append')
    if log:
            logger.info(f'Table {table_name} updated')

    os.remove(f'/tmp/temp_{table_name}.csv')
    