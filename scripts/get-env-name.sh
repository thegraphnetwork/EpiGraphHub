#!/usr/bin/env bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd .. && pwd )"

. ${PROJECT_PATH}/scripts/load-dotenv.sh

echo -n ${ENV}
