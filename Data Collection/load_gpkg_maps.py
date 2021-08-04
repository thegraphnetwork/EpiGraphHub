#!/usr/bin/env python3
import geopandas as gpd
import inquirer
import glob
import os
from sqlalchemy import create_engine

load_dotenv('.env_db')
PGUSER = 'epigraph'
PGPASS = 'epigraph'
PGHOST = 'localhost'
PGDB = 'epigraphhub'

questions = [
    inquirer.Path('maps_dir',
                  message="Enter directory where the gpkg maps located(don't forget the trailing '/')",
                  path_type=inquirer.Path.DIRECTORY,
                  )
]


def insert_into_postgis(pth):
    maps = glob.glob(os.path.join(pth, '*gadm36_*.gpkg'))
    engine = create_engine(f"postgresql://{PGUSER}:{PGPASS}@{PGHOST}/{PGDB}")
    for m in maps:
        fname = os.path.split(m)[-1]
        print(f"Inserting {fname} into PostGIS.")
        Map = gpd.read_file(m, driver='GPKG')
        country_name = fname.split('_')[0]
        try:
            Map.to_postgis(country_name, engine, if_exists='replace')
        except Exception as e:
            print(f"Loading of the {country_name} maps failed:/n{e}")



def main(answers):
    insert_into_postgis(answers['maps_dir'])


if __name__ == '__main__':
    answers = inquirer.prompt(questions)
    main(answers)
