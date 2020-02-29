#!/bin/bash
# cross-pi-buildroot.sh
# Build the cross-compiler toolchain for Raspberry PI
#
# references: 
#   https://buildroot.org/
#   https://buildroot.org/downloads/manual/manual.html 
#

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

# Fetch the latest buildroot
cd $HOME
mkdir -p cross-pi-build
pushd cross-pi-build > /dev/null 
git clone https://git.buildroot.net/buildroot

# Move to the buildroot directory 
cd buildroot

# Make sure pkg-config and QT is installed so that make xconfig (below) will actually work
sudo apt install pkg-config qt5-default

# list all available buildroot configurations
make list-defconfigs

# Select default Raspberry PI buildroot configuration
make raspberrypi_defconfig

# Manually update the Raspberry PI buildroot configuration generated
make xconfig

# It is very important that this is done correctly
# NOTE1: The settings below are in addition to the default ones

# 1. Toolchain 
#       >  C library 
#          (x)   glibc

# 2  Target packages
#       >  Graphics libraries and applications
#          [x] x.org X Window System

# 3  Target packages
#       > Libraries
#         >  Graphics
#             [x] libgtk2

# 4  Target packages
#       > Libraries
#         > [x] cairo   

# NOTE2: You must use File -> Save after making the changes

echo "To build the toolchain will take 2+ hours. "
read -p "Do you want to build it now (y/n)?" choice
DELAY_BUILD=0;
case "$choice" in 
  y|Y ) make ;;
  * ) DELAY_BUILD=1;;
esac

if (( DELAY_BUILD > 0 )) ; then
	echo " "
	echo "To build toolchain manually, please do:"
	echo " "
	echo "   cd ~/cross-pi-build/buildroot"
	echo "   make"
	echo " "
fi

echo "When built, the toolchain will be in ~/cross-pi-build/buildroot/output/host/usr/bin"
