#!/bin/bash
# This script copies the cross-pi sample executables from the stage area to the remote Raspberry PI using scp and SSH

BIN_DIR=$HOME/cross-pi-build/samples/stage
DEFAULT_USER="pi"
DEFAULT_HOST="10.0.0.233"

read -p    "Remote host address [$DEFAULT_HOST]?" HOST
read -p    "Remote user name    [$DEFAULT_USER]?" USER

if [[ -z "$USER" ]]; then  USER=$DEFAULT_USER; fi
if [[ -z "$HOST" ]]; then  HOST=$DEFAULT_HOST; fi

# copy the files (requires SSH enabled on the host)
scp $BIN_DIR/* $USER@$HOST:/home/$USER/Downloads

