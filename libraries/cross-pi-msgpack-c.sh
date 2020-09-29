#!/bin/bash
# cross-pi-msgpack.sh
# Cross-compile msgpack for Raspberry PI, using toolchain generated by cross-pi-buildroot.sh

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

# make sure the installation root folder exists
mkdir -p $HOME/cross-pi-build
TARGET_DIR=$HOME/cross-pi-build/libraries/msgpack-c

# download the boost code, store in temporary directory
rm -Rf /tmp/build_msgpack-c
mkdir -p /tmp/build_msgpack-c
pushd /tmp/build_msgpack-c  > /dev/null
git checkout cpp_master

# Get msgpack-c source from github
git clone https://github.com/msgpack/msgpack-c.git
pushd msgpack-c/ > /dev/null 

# cmake must be informed about the cross compiler(s) using a special toolchain cmake file
echo "set(CMAKE_C_COMPILER   $HOME/cross-pi-build/buildroot/output/host/bin/arm-linux-gcc )" >  ./rpi_toolchain.cmake
echo "set(CMAKE_CXX_COMPILER $HOME/cross-pi-build/buildroot/output/host/bin/arm-linux-g++ )" >> ./rpi_toolchain.cmake
echo "set(CMAKE_SYSROOT      $HOME/cross-pi-build/buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot/ )" >> ./rpi_toolchain.cmake

# invoke cmake with the given toolchain
cmake -D CMAKE_TOOLCHAIN_FILE=./rpi_toolchain.cmake .

# run make and install to DESTDIR
make DESTDIR=${TARGET_DIR} install

# back up directory tree
popd > /dev/null
popd > /dev/null

if [ -d "$TARGET_DIR" ]; then
  echo "msgpack-c library was installed to ${TARGET_DIR}"
else
  echo "Error: ${TARGET_DIR} not found. Build failed"
  exit 1
fi
