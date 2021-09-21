#!/usr/bin/env bash

cd /opt/EpiGraphHub/Data_Collection/CRON_scripts
/root/superset/bin/python3 owid_fetch.py local
