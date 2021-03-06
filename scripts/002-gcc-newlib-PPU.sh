#!/bin/sh -e
# gcc-newlib-PPU.sh by Dan Peori (dan.peori@oopo.net)

GCC="gcc-4.9.0"
NEWLIB="newlib-2.1.0"

## Download the source code.
if [ ! -f ${GCC}.tar.bz2 ]; then wget --continue ftp://ftp.gnu.org/gnu/gcc/${GCC}/${GCC}.tar.bz2; fi
if [ ! -f ${NEWLIB}.tar.gz ]; then wget --continue ftp://sources.redhat.com/pub/newlib/${NEWLIB}.tar.gz; fi

## Remove the directories and unpack the source code
rm -Rf ${GCC} && tar -jxvf ${GCC}.tar.bz2
rm -Rf ${NEWLIB} && tar -zxvf ${NEWLIB}.tar.gz

## Patch the source code if a patch file exists.
if [ -f ../patches/${GCC}-PS3.patch ]; then
  echo "Patching ${GCC}"
  cat ../patches/${GCC}-PS3.patch | patch -p1 -d ${GCC}
  fi

if [ -f ../patches/${NEWLIB}-PS3.patch ]; then
  echo "Patching ${NEWLIB}"
  cat ../patches/${NEWLIB}-PS3.patch | patch -p1 -d ${NEWLIB}
fi

## Enter the source code directory.
cd ${GCC}

## Create the newlib symlinks.
ln -s ../${NEWLIB}/newlib newlib
ln -s ../${NEWLIB}/libgloss libgloss

## Download the prerequisites.
./contrib/download_prerequisites

## Leave the source code directory.
cd ..

## Create the build directory.
if [ ! -d ${GCC}/build-ppu ]; then
  mkdir ${GCC}/build-ppu
fi

## Enter the build directory.
cd ${GCC}/build-ppu

## Configure the build.
../configure --prefix="$PS3DEV/ppu" --target="powerpc64-ps3-elf" \
    --disable-dependency-tracking \
    --disable-libstdcxx-pch \
    --disable-multilib \
    --disable-nls \
    --disable-shared \
    --disable-win32-registry \
    --enable-languages="c,c++" \
    --with-long-double-128 \
    --enable-lto \
    --enable-threads \
    --with-cpu="cell" \
    --with-newlib \
    --with-system-zlib

## Compile and install.
${MAKE:-make} -j 4 all && ${MAKE:-make} install
