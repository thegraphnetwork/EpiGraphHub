#!/usr/bin/env bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd .. && pwd )"
export $(echo $(cat ${PROJECT_PATH}/.env | sed 's/#.*//g'| xargs) | envsubst)

set -ex
mkdir -p ${SUPERSET_DB_PATH_DIR_HOST}
sqlite3 ${SUPERSET_DB_PATH_HOST} "VACUUM;" ".quit"
chmod -R 777 ${SUPERSET_DB_PATH_DIR_HOST}
