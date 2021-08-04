#!/usr/bin/env python3
'''
This script fetches updated csvs from OWID and uploads them to the Epigraphhub database
It can be run remotely as long as the user has a public key in the server.
to run as a CRON process locally, it must be run with the argument `local`
'''
import pandas as pd
import os, sys
import shlex
import subprocess
from sqlalchemy import create_engine

HOST = '135.181.41.20'
TEMP_PATH = '/tmp/owid'
DATA_PATH = os.path.join(TEMP_PATH, 'releases')
if not os.path.exists(DATA_PATH): os.mkdir(DATA_PATH)
OWID_URL = 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
FILENAME = OWID_URL.split('/')[-1]


def download_csv():
    subprocess.run(['curl', '--silent', '-f', '-o', f'{DATA_PATH}/{FILENAME}', f'{OWID_URL}'])


def parse_types(df):
    df = df.convert_dtypes()
    df['date'] = pd.to_datetime(df.date)
    return df


def load_into_db(remote=True):
    if remote:
        proc = subprocess.Popen(shlex.split(f'ssh -f epigraph@{HOST} -L 5432:localhost:5432 -NC'))
    try:
        download_csv()
        data = pd.read_csv(os.path.join(DATA_PATH, FILENAME))
        data = parse_types(data)
        engine = create_engine('postgresql://epigraph:epigraph@localhost:5432/epigraphhub')
        data.to_sql('owid_covid', engine, index=False, if_exists='replace', method='multi', chunksize=10000)
    finally:
        if remote:
            proc.kill()


if __name__ == '__main__':
    if 'local' in sys.argv:
        load_into_db(False)
    else:
        load_into_db()
