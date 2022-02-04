#!/usr/bin/env bash

export CONTAINER_NAME=${1:-"dev-epigraphhub"}
export CONTAINER_NAME="docker_${CONTAINER_NAME}_1"

echo "[II] Checking ${CONTAINER_NAME} ..."

while [ "`docker inspect -f {{.State.Health.Status}} ${CONTAINER_NAME}`" != "healthy" ]; 
do
    echo "[II] Waiting for ${CONTAINER_NAME} ..."
    sleep 5;
done

echo "[II] ${CONTAINER_NAME} is healthy."
