#!/bin/bash
# cross-pi-cb-build-from-source.sh
# This script downloads, builds and installs Code::Blocks under debian/ubuntu
# The installation will be in /usr , it will override any system package
# Run this script with sudo privilege

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root (it will perform some root operations with sudo)" 1>&2
  exit 1
fi

sudo apt update
sudo apt upgrade
sudo apt install debhelper cdbs automake libtool libwxgtk3.0-dev wx-common libbz2-dev zlib1g-dev libgtk2.0-dev libgamin-dev libboost-dev  libboost-system-dev libhunspell-dev libfontconfig1-dev libglib2.0-dev xterm


#build in a temporary, disposable folder
rm -Rf   /tmp/build_codeblocks
mkdir -p /tmp/build_codeblocks
pushd    /tmp/build_codeblocks/ > /dev/null 
#
# fetch latest from github
git clone https://github.com/obfuscated/codeblocks_sf
#
# build the *.deb files
pushd  codeblocks_sf/ > /dev/null 
#
# Run the bootstrap script first
./bootstrap
#
# Then build the *.deb files
dpkg-buildpackage -us -uc
#
# install from the just created *.deb files
popd > /dev/null
sudo dpkg -i *.deb
#
# return to original directory
popd > /dev/null
echo "Code::Blocks has been installed! "
