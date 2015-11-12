#!/bin/sh
#
# Run this script to set up the qsim environment for the first time.
# You can read the following steps to see what each is doing.
#
# Author: Pranith Kumar
# Date: 01/03/2015

# clone qsim
echo "sudo apt-get -y build-dep qemu"
sudo apt-get -y build-dep qemu
echo "Cloning qsim..."
git clone --recursive https://github.com/pranith/qsim
cd qsim
# use branch v2.0
git checkout -b v2.1-qsim v2.1-qsim

# set the QSIM environment variable
echo "Setting QSIM environment variable..."
export QSIM_PREFIX=`pwd`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$QSIM_PREFIX/lib
echo "Add the following lines to your bashrc"
echo "export QSIM_PREFIX=$QSIM_PREFIX"
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\$QSIM_PREFIX/lib"

# build qemu
echo "\nConfiguring and building qemu...\n"
cd build
../arm64-build.sh release

# build qsim
make -j4
# copy header files to include directory
make install

# capstone disassembler
git clone https://github.com/pranith/capstone
cd capstone
git checkout -b arm64_reg_access origin/arm64_reg_access
./make.sh
cp include/capstone/*.h $QSIM_PREFIX/include/
cp libcapstone.so $QSIM_PREFIX/lib/
cd ../..

# get qemu images
echo "\nDownloading arm QEMU images..."
# wget https://www.dropbox.com/s/wtie9kghc95em7o/qsim_arm_images.tar.bz2?dl=0
# wget https://www.dropbox.com/s/ekglfaqogewrojl/arm_images.tar.bz2?dl=0 -O arm_images.tar.bz2
# wget https://www.dropbox.com/s/u7mk3x37tg65vwb/arm64_images.tar.bz2?dl=0 -O arm64_images.tar.bz2
wget -c https://www.dropbox.com/s/2jplu61410tfime/arm64_images.tar.xz?dl=0 -O arm64_images.tar.xz
wget -c https://www.dropbox.com/s/4ut7e4d5ygty020/x86_64_images.tar.xz?dl=0 -O x86_64_images.tar.xz

echo "\nUncompresssing images. This might take a while..."
tar -xf arm64_images.tar.xz
tar -xf x86_64_images.tar.xz

# run simple example
# echo "Running the cache simulator example..."
# cd qsim/arm-examples/
# make && ./cachesim
