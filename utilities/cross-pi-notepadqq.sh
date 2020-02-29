#!/bin/bash
# cross-pi-notepadqq.sh
# This script builds and installs the notepadqq text editor

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

pushd /tmp > /dev/null 
mkdir build_notepadqq
pushd build_notepadqq > /dev/null 

# get source
git clone --recursive https://github.com/notepadqq/notepadqq
cd notepadqq

# install known dependencies
sudo apt-get install qt5-default qttools5-dev-tools qtwebengine5-dev libqt5websockets5-dev libqt5svg5 libqt5svg5-dev libuchardet-dev pkg-config

# configure and build 
./configure --prefix=/usr
make

# install 
sudo make install


echo "Notepadqq installed"
