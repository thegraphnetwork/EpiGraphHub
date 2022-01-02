import pandas as pd
from pangres import upsert
from sqlalchemy import create_engine, text, VARCHAR
import requests
import logging
from logging.handlers import RotatingFileHandler

logger = logging.getLogger("foph_fetch")
fh = RotatingFileHandler('/var/log/foph_fetch.log', maxBytes=2000, backupCount=5)
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)
logger.addHandler(fh)

HOST = 'epihraphhub.org'  #'135.181.41.20'

context_url = "https://www.covid19.admin.ch/api/data/context"
context = requests.get(context_url).json()
TABLES = context['sources']['individual']['csv']['daily']


def load_into_db(table, url, log=True):
    new_df = pd.read_csv(url)
    new_df.index.name = 'id_'
    if not 'date' in new_df.columns:
        new_df['date'] = pd.to_datetime(new_df.datum)
    else:
        new_df['date'] = pd.to_datetime(new_df.date)
    if log:
        logger.info(f'Table {table} downloaded')
    
    engine = create_engine('postgresql://epigraph:epigraph@localhost:5432/epigraphhub')
    upsert(engine=engine, df=new_df, table_name=f'foph_{table.lower()}', schema='switzerland', if_row_exists='update',
       chunksize=1000, create_table=True) 
    if log:
        logger.info(f'Table {table} updated')
    with engine.connect() as connection:
            try:
                connection.execute(f'CREATE INDEX IF NOT EXISTS region_idx  ON switzerland.foph_{table.lower()} (geoRegion);')
            except Exception as e:
                logger.info(f'Could not create region index: {e}')
            try:
                connection.execute(f'CREATE INDEX IF NOT EXISTS date_idx ON switzerland.foph_{table.lower()} (date);')
            except Exception as e:
                logger.info(f'Could not create date index: {e}')


if __name__ == "__main__":
    for t,u in TABLES.items():
        logger.info(f'Attempting to Download {t} from {u}.')
        load_into_db(t,u)