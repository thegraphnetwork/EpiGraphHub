#!/usr/bin/env python3

from subprocess import Popen, run
import shlex
import os
import inquirer
from glob import glob

URL = "https://biogeo.ucdavis.edu/data/gadm3.6/gpkg/"

questions = [
    inquirer.Path('maps_dir',
                  message="Enter directory where the gpkg should be downloaded to (don't forget the trailing '/')",
                  path_type=inquirer.Path.DIRECTORY,
                  ),
    inquirer.Confirm('clean',message='Do you want to delete the zipped after GPKGs have been extracted?')
]

def get_codes():
    codes = []
    with open('ISO-alpha3-codes.csv','r', encoding='utf8') as f:
        for l in f.readlines():
            codes.append(l.split(';')[0])
    return codes

def fetch_files(savepath, clean=False):
    for code in get_codes():
        proc = Popen(shlex.split(f'wget {URL}gadm36_{code}_gpkg.zip'))
        proc.wait()
    for zf in glob('*.zip'):
        run(f"unzip '{zf}'")
    if clean:
        os.unlink('*.zip')


if __name__=="__main__":
    answers = inquirer.prompt(questions)
    fetch_files(answers['maps_dir'], answers['clean'])


