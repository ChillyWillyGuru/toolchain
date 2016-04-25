#!/bin/sh -e
# 011-ps3libraries.sh by Spork Schivago (SporkSchivago@gmail.com)

PS3LIBS="PS3Libraries"

## Remove the directory and clone the source code from our github repository
rm -rf ${PS3LIBS}
git clone https://github.com/ChillyWillyGuru/${PS3LIBS}

## Create the build directory.
cd ${PS3LIBS}

## Compile and install.
./libraries.sh
