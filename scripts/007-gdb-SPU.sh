#!/bin/sh -e
# gdb-SPU.sh by Dan Peori (dan.peori@oopo.net)

GDB="gdb-7.7.1"

if [ ! -d ${GDB} ]; then
  ## Download the source code.
  if [ ! -f ${GDB}.tar.bz2 ]; then wget --continue ftp://ftp.gnu.org/gnu/gdb/${GDB}.tar.bz2; fi

  ## Unpack the source code.
  tar -jxvf ${GDB}.tar.bz2
fi

if [ ! -d ${GDB}/build-spu ]; then
  ## Create the build directory.
  mkdir ${GDB}/build-spu
fi

## Enter the build directory.
cd ${GDB}/build-spu

## Configure the build.
../configure --prefix="$PS3DEV/spu" --target="spu" \
    --disable-nls \
    --disable-sim \
    --disable-werror

## Compile and install.
${MAKE:-make} -j 4 && ${MAKE:-make} install
