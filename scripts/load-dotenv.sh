#!/usr/bin/env bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export $(echo $(cat ${PROJECT_PATH}/.env | sed 's/#.*//g'| xargs) | envsubst)
