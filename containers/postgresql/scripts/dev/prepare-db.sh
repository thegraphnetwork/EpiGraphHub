#!/usr/bin/env bash

# =================================
# NOTE: USE IT JUST FOR DEVELOPMENT
# =================================

set -ex

CONTAINER_APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd ../../.. && pwd )"
PSQL_CONNECTION="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}"

echo "[II] CREATE DATABASE"
psql "${PSQL_CONNECTION}/postgres" < ${CONTAINER_APP_DIR}/sql/dev/database.sql

echo "[II] LOAD EPIGRAPHHUB DUMP"
psql "${PSQL_CONNECTION}/${POSTGRES_EPIGRAPH_DB}" < ${CONTAINER_APP_DIR}/sql/dev/epigraphhub.sql

echo "[II] LOAD PRIVATE DUMP"
psql "${PSQL_CONNECTION}/${POSTGRES_EPIGRAPH_DB_PRIVATE}" < ${CONTAINER_APP_DIR}/sql/dev/privatehub.sql
