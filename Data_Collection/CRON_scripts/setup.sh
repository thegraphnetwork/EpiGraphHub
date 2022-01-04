#!/usr/bin/env bash

# prepare the conda environment
using_conda=$(echo $PATH|grep -m 1 --count /conda)

if [ $using_conda == 1 ]; then
  # activate from conda
  source activate epigraphhub;
  echo "[II] conda env activated."
else
  source /root/superset/bin/activate
  echo "[II] venv activated."
fi
