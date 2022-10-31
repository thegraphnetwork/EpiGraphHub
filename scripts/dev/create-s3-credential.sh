#!/usr/bin/env bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd ../.. && pwd )"

. ${PROJECT_PATH}/scripts/load-dotenv.sh

set -ex
aws --profile default configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws --profile default configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
aws --profile default configure set aws_default_region ${AWS_DEFAULT_REGION}
