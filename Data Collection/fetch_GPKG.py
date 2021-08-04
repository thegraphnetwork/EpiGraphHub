from subprocess import Popen, run
import shlex
import os
from glob import glob

URL = "https://biogeo.ucdavis.edu/data/gadm3.6/gpkg/"

def get_codes():
    codes = []
    with open('ISO-alpha3-codes.csv','r', encoding='utf8') as f:
        for l in f.readlines():
            codes.append(l.split(';')[0])
    return codes

def fetch_files():
    for code in get_codes():
        proc = Popen(shlex.split(f'wget {URL}gadm36_{code}_gpkg.zip'))
        proc.wait()
    for zf in glob('*.zip'):
        run(f'unzip {zf}')

if __name__=="__main__":
    fetch_files()


