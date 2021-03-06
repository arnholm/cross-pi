#!/bin/bash
# cross-pi-wxwidgets.sh
# Cross-compile wxWidgets for Raspberry PI, using toolchain generated by cross-pi-buildroot.sh

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

# exclude some rarely used stuff
# change =no to =yes or omit =no to include in build ( we have removed --with-opengl from ENABLE)
XTIFF="--with-libtiff=no"
XJPEG="--with-libjpeg=yes"
ODBC="--with-odbc=no"

# put here things to explicitely enable  
ENABLE="--with-gtk --enable-unicode --enable-dnd --enable-dataobj --enable-graphics-ctx"

# put here things to explicitely disable
DISABLE="--enable-shared=no --enable-iff=no --enable-tga=no --enable-pcx=no --enable-mediactrl=no --enable-dialupman=no --with-libmspack=no"

# argument can be D for debug version
if [ "$1" = "D" ] ; 
then
  DEB="--enable-debug"
else
  DEB="--enable-debug=no"
fi

WX_VERSION="3.0.4"
WX_NAME="wxWidgets-${WX_VERSION}"

# make sure  our root folder exists
mkdir -p $HOME/cross-pi-build

# Download wxwidgets and build in a temporary, disposable folde
wget https://github.com/wxWidgets/wxWidgets/releases/download/v${WX_VERSION}/${WX_NAME}.tar.bz2 -P /tmp/build_wxwidgets

# Extract the download package
pushd /tmp/build_wxwidgets/ > /dev/null 
tar -xvf ./${WX_NAME}.tar.bz2 
pushd ${WX_NAME}/ > /dev/null 

# create a build folder for Raspberry PI
mkdir buildrpi
pushd buildrpi > /dev/null 

# make sure the buildroot toolchain is first in PATH so we find the correct cross-compiler 
export PATH=$HOME/cross-pi-build/buildroot/output/host/usr/bin:$PATH

# Tell g++ where the cross-compiler sysroot is
export CXXFLAGS="--sysroot=$HOME/cross-pi-build/buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot/ $CXXFLAGS"

# this is where cross-compled wxWidgets will be installed
TARGET_DIR="$HOME/cross-pi-build/libraries/${WX_NAME}"

# the target host system is Raspberry PI, a.k.a. arm-linux
CFG_HOST="arm-linux"

# Run the wxwidgets configure script
../configure --host=${CFG_HOST} --prefix=${TARGET_DIR}  ${ENABLE} ${DISABLE} ${XJPEG} ${XTIFF} ${ODBC} ${DEB}
if [ $? != 0 ]; then exit -1 ; fi

# build the wxWidgets libraries
make
if [ $? != 0 ]; then exit -1 ; fi

# install to the TARGET_DIR folder
make install
if [ $? != 0 ]; then exit -1 ; fi

# back up directory tree
popd > /dev/null
popd > /dev/null
popd > /dev/null


if [ -d "$TARGET_DIR" ]; then
  echo "wxWidgets libraries were installed to ${TARGET_DIR}"
else
  echo "Error: ${TARGET_DIR} not found. Build failed"
  exit 1
fi
