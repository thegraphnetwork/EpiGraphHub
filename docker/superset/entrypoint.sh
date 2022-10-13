#!/usr/bin/env bash

set -ex

# prepare the conda environment
is_conda_in_path=$(echo $PATH|grep -m 1 --count /opt/conda/)

if [ $is_conda_in_path == 0 ]; then
  export PATH="/opt/conda/condabin:/opt/conda/bin:$PATH"
  echo "[II] included conda to the PATH"
fi

echo "[II] activate epigraphhub"
source activate epigraphhub

# patch superset

SUPERSET_DIR="$(find ${CONDA_PREFIX} -name superset |grep site-packages/superset$)"
TEMPLATE_DIR=${SUPERSET_DIR}/templates/superset
STATIC_DIR=${SUPERSET_DIR}/static/assets
# link the superset welcome page
rm -f $TEMPLATE_DIR/public_welcome.html
ln -s /opt/superset/public_welcome.html $TEMPLATE_DIR
# link logo image
cp --symbolic-link --remove-destination /opt/superset/images/* $STATIC_DIR/images/

if [ $# -ne 0 ]
  then
    echo "Running: ${@}"
    $(${@})
fi
