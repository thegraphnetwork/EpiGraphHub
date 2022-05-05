#!/usr/bin/env bash

# =================================
# NOTE: USE IT JUST FOR DEVELOPMENT
# =================================

set -ex

DOCKER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd .. && pwd )"

echo "[II] CREATE DATABASE"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/postgres" \
    < ${DOCKER_DIR}/sql/database.sql

echo "[II] LOAD EPIGRAPHHUB DUMP"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB" \
    < ${DOCKER_DIR}/sql/epigraphhub.sql

echo "[II] LOAD PRIVATE DUMP"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB_PRIVATE" \
    < ${DOCKER_DIR}/sql/privatehub.sql
