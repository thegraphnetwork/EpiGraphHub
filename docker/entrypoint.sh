#!/usr/bin/env bash

# prepare the conda environment
is_conda_in_path=$(echo $PATH|grep -m 1 --count /opt/conda/)

if [ $is_conda_in_path == 0 ]; then
  export PATH="/opt/conda/condabin:/opt/conda/bin:$PATH"
  echo "[II] included conda to the PATH"
fi

echo "[II] activate epigraphhub"
source activate activate epigraphhub

# link the superset welcome page
TEMPLATE_DIR=${CONDA_PREFIX}/lib/python3.7/site-packages/superset/templates/superset
rm -f $TEMPLATE_DIR/public_welcome.html
ln -s /opt/superset/public_welcome.html $TEMPLATE_DIR

if [ $# -ne 0 ]
  then
    $(${@})
fi
