#!/usr/bin/env bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd ../.. && pwd )"

if [ -f ${PROJECT_DIR}/.env ]; then
    # Load Environment Variables
    export $(cat ${PROJECT_DIR}/.env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

POSTGRES_DUMP_HOST=${POSTGRES_DUMP_HOST:-/tmp/dump}

set -ex

PGPASSWORD=${POSTGRES_PASSWORD} psql \
  --host ${POSTGRES_HOST} \
  --port ${POSTGRES_PORT} \
  --user ${POSTGRES_USER} \
  -f ${POSTGRES_DUMP_HOST}/${1} ${POSTGRES_DB}
