#!/usr/bin/env bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd ../ && pwd )"

env $(cat ${PROJECT_DIR}/.env)

export CONTAINER_NAME=${1:-"epigraphhub-superset"}
export CONTAINER_NAME="eph-${ENV:-dev}_${CONTAINER_NAME}_1"

echo "[II] Checking ${CONTAINER_NAME} ..."

while [ "`docker inspect -f {{.State.Health.Status}} ${CONTAINER_NAME}`" != "healthy" ];
do
    echo "[II] Waiting for ${CONTAINER_NAME} ..."
    sleep 5;
done

echo "[II] ${CONTAINER_NAME} is healthy."
