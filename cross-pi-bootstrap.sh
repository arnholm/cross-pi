#!/bin/bash
# cross-pi-bootstrap.sh
# This script installs ubuntu system packages required for  the cross build tools

sudo apt-get update
sudo apt-get upgrade
sudo apt install git wget pkg-config qt5-default build-essential cmake
mkdir -p $HOME/cross-pi-build

echo "Essential system packages for cross-pi have been installed!"
