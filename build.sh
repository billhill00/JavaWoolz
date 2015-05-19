#!/bin/sh
# This script will configure and build JavaWoolz. Uncomment the appropriate
# configure command line for the build you want. JavaWoolz requires a full
# build of Woolz. The easiest way to use this script is probably to copy it
# to mybuild.sh and the edit that script.

set -x
# In most cases a simple autoreconf should be sufficient
autoreconf
# If you hit problems with missing files or libtool use the following
# autoreconf
# autoreconf -i --force

#export MA=$HOME
#export MA=$HOME/MouseAtlas/Build/
export MA=/opt/MouseAtlas

# Build JavaWoolz optimised with the minimum of dynamic libraries and tests
# to run the tests after having built JavaWoolz cd to uk/ac/mrc/hgu/Wlz/Test 
# and run
#   make demo
./configure --with-static-woolz=$MA --with-static-nifti=$MA --with-static-tiff=$MA --with-static-jpeg=$MA --enable-openmp --enable-optimise --enable-test

