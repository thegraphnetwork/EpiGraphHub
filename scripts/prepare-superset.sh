#!/usr/bin/env bash

export $(grep -v '^#' .env | xargs -d '\n')

set -ex

mkdir -p ${SUPERSET_DB_PATH_DIR_HOST}
sqlite3 ${SUPERSET_DB_PATH_HOST} "VACUUM;"
chmod -R 777 ${SUPERSET_DB_PATH_DIR_HOST}
