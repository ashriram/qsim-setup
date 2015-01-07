#!/bin/sh
#
# Run this script to set up the qsim environment for the first time.
# You can read the following steps to see what each is doing.
#
# Author: Pranith Kumar
# Date: 01/03/2015

# clone qsim
echo "Cloning qsim..."
git clone https://github.com/pranith/qsim
cd qsim
# use branch armport
git checkout -b armport origin/armport

# set the QSIM environment variable
echo "Setting QSIM environment variable..."
export QSIM_PREFIX=`pwd`

# clone qemu
echo "Cloning qemu..."
git clone https://github.com/pranith/qemu
cd qemu
# use branch callbacks
git checkout -b callbacks origin/callbacks
cd ..

# create lib, include, build directories
mkdir -p lib include build

# build qsim
make -j4
# copy header files to include directory
cp *.h include/
# build qemu
cd build
../arm-build.sh

# copy built libraries
cp arm-softmmu/qemu-system-arm lib/libqemu-qsim.so
cd ..
cp libqsim.so lib/

# get qemu images
echo "Downloading arm QEMU images..."
wget https://www.dropbox.com/s/wtie9kghc95em7o/qsim_arm_images.tar.bz2?dl=0
# cp ~/devops/Dropbox/qsim-ARM/qsim_arm_images.tar.bz2 .
tar -xjvf qsim_arm_images.tar.bz2
tar -xvf qsim_arm_images.tar

# run simple example
echo "Running the simple example..."
cd arm-examples/
make && ./cachesim
