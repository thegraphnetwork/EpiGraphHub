#!/bin/sh

set -e

if [ "$ENV" == "dev" ]; then
  # prepare-db
fi

exec postgres "$@"
