#!/bin/bash
# This script installs the cross-pi sample applications to the build area

# get file name of this script
this_script=`basename "$0"`

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

# copy the samples to the build area
SAMPLES_DIR=$HOME/cross-pi-build/samples
mkdir -p ${SAMPLES_DIR}
mkdir -p ${SAMPLES_DIR}/stage
rsync -r --verbose --exclude ${this_script} ./* ${SAMPLES_DIR}

echo "samples copied"