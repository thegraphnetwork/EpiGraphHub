#!/usr/bin/env bash

cd /opt/EpiGraphHub/Data_Collection/CRON_scripts
source setup.sh
python google_health_daily.py
