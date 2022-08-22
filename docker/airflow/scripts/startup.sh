#!/usr/bin/env bash

set -ex

# initdb
chmod +x /opt/scripts/init-db.sh
/opt/scripts/init-db.sh

# start airflow
airflow webserver &
sleep 10

# start scheduler
# airflow scheduler &
# sleep 10

# just to keep the prompt blocked
mkdir -p /tmp/empty
cd /tmp/empty
python -m http.server
