#!/bin/sh -e
# gdb-PPU.sh by Dan Peori (dan.peori@oopo.net)

GDB="gdb-7.7.1"

if [ ! -d ${GDB} ]; then
  ## Download the source code
  if [ ! -f ${GDB}.tar.bz2 ]; then wget --continue ftp://ftp.gnu.org/gnu/gdb/${GDB}.tar.bz2; fi

  ## Unpack the source code.
  tar -jxvf ${GDB}.tar.bz2
fi

## Create the build directory.
if [ ! -d ${GDB}/build-ppu ]; then
  mkdir ${GDB}/build-ppu
fi

## Enter the build directory.
cd ${GDB}/build-ppu

## Configure the build.
../configure --prefix="$PS3DEV/ppu" --target="powerpc64-ps3-elf" \
    --disable-multilib \
    --disable-nls \
    --disable-sim \
    --disable-werror

## Compile and install.
${MAKE:-make} -j 4 && ${MAKE:-make} install
