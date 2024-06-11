#!/usr/bin/env bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd ../ && pwd )"

if [ -f ${PROJECT_DIR}/.env ]; then
    # Load Environment Variables
    export $(cat ${PROJECT_DIR}/.env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

export CONTAINER_NAME=${1:-"superset"}
export CONTAINER_NAME="egh-${ENV:-dev}-${CONTAINER_NAME}-1"

echo "[II] Checking ${CONTAINER_NAME} ..."

while [ "`docker inspect -f {{.State.Health.Status}} ${CONTAINER_NAME}`" != "healthy" ];
do
    echo "[II] Waiting for ${CONTAINER_NAME} ..."
    sleep 5;
done

echo "[II] ${CONTAINER_NAME} is healthy."
