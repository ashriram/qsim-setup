qsim-setup
==========

This is a script which helps you to setup the qsim emulation environment. You
will need atleast 12 GB of space for the ARM disk images and for building qemu.

The script itself is self explanatory. Clone this repository and then run
setup.sh in the folder where you want to setup the build.

This has been tested on Ubuntu 14.04. Patches for other distributions are
welcome.

Please install the build dependencies for qemu as follows:

$ sudo apt-get build-dep qemu

Also install the following libraries:

$ sudo apt-get install libpixman-1-dev libfdt-dev
