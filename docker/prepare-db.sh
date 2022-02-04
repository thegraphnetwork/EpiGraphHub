#!/usr/bin/env bash

# =================================
# NOTE: USE IT JUST FOR DEVELOPMENT
# =================================

set -ex

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "[II] CREATE DATABASE"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/postgres" \
    < ${CURRENT_DIR}/sql/database.sql

echo "[II] LOAD EPIGRAPHHUB DUMP"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB" \
    < ${CURRENT_DIR}/sql/epigraphhub.sql

echo "[II] LOAD PRIVATE DUMP"
psql "postgresql://postgres:postgres@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB_PRIVATE" \
    < ${CURRENT_DIR}/sql/privatehub.sql
