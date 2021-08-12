#!/usr/bin/env python3
import geopandas as gpd
import inquirer
import glob
import os
import json
from sqlalchemy import create_engine
import fiona

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


def process_maps(gdf):
    """
    Adds additional geometry columns to the map
    :param gdf: geodataframe
    """
    # create JSON column
    gdf['json'] = [json.dumps(pol.__geo_interface__) for pol in gdf.geometry]
    gdf['Latitude'] = [pol.centroid.y for pol in gdf.geometry]
    gdf['Longitude'] = [pol.centroid.x for pol in gdf.geometry]
    return gdf


def insert_into_postgis(pth):
    maps = glob.glob(os.path.join(pth, '*gadm36_*.gpkg'))
    engine = create_engine(f"postgresql://{PGUSER}:{PGPASS}@{PGHOST}/{PGDB}")
    for m in maps:
        fname = os.path.split(m)[-1]
        fname_noext = fname.split('.')[0]
        layers = fiona.listlayers(m)
        print(f"Inserting {len(layers)} layers of {fname} into PostGIS.")
        for i, layer in enumerate(layers):  # Importing all layers separately
            Map = gpd.read_file(m, layer=f'{fname_noext}_{layer}', driver='GPKG')
            Map = process_maps(Map)
            country_name = fname_noext.split('_')[1]
            try:
                Map.to_postgis(f"{country_name}_{i}", engine, if_exists='replace')
            except Exception as e:
                print(f"Loading of {country_name}_{i} map failed:/n{e}")
                raise e


def main(answers):
    insert_into_postgis(answers['maps_dir'])


if __name__ == '__main__':
    answers = inquirer.prompt(questions)
    main(answers)
