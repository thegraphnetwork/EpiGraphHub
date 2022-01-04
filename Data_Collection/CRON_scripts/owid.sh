#!/usr/bin/env bash

cd /opt/EpiGraphHub/Data_Collection/CRON_scripts
source setup.sh
python owid_fetch.py local
