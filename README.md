Toolchain
=========

This is a fork of a beta version of a more up-to-date toolchain for the PS3 by Spork-Schivago which includes
the PS3Libraries with some additions and the Enlightenment Foundation Libraries.

Have a look at **PACKAGES** to see what's included and check out **STATUS** to the see the current status.

  **Current Issues**

  The following is by Spork. He no longer maintains the toolchain. I am trying to pick up where he left off,
  so if you find any problems or want to contribute, e-mail me at ChillyWillyGuru@gmail.com. As I check into
  this, I'll edit the section below to reflect the current state of the toolchain.

   There are some currently known problems.  Libbfd and libiberty weren't meant to be standalone libraries.  I needed
   a PPU version of libiberty to compile a PS3 program or two so I recompiled it from the binutils package as a
   powerpc64 library.  To get libbfd to work, you might need to add the libiberty library to the linker options.

   I had trouble running the example from Wargio's NoRSX library.  It ran extremely slow and I couldn't exit. After
   talking to Wargio, him and I both believe it's something with my toolchain.

   I can only test this in Linux because that's all I run.  I doubt the mingw-toolchain.sh script will work.  If you
   notice a problem and can fix it, please send me a patch or tell me how it's done so I can update the repository.
   I worked for a long time on this and I doubt I'll be able to spend much time in the near future fixing it.  I'll try
   to work on it when I can.  If anyone wants to help, please let me know via e-mail at SporkSchivago@gmail.com.

   If your programs no longer compile, the code or Makefile might need to be modified.  You might need to switch the
   order of the libraries around.  For example, for the PSChannel homebrew application, I had to modify the Makefile.
   Under the LIBS section, I had to change this line:
   -lsysutil -levas -leina -lescape -lnet -lsysmodule -liberty -leet \
   -lembryo -llua -lm -lfontconfig -lcares -lexpat -lSDL \

   to this:
   -lsysutil -levas -lEGL -lGL -leina -lescape -lnet -lsysmodule -leet \
   -lembryo -llua -lm -lfontconfig -liberty -lcares -lexpat -lSDL \

   and this line:
   -lfreetype -lsysfs -lpolarssl

   to this:
   -lfreetype -lsysfs -lpolarssl -ltiff -lpixman-1

   For the CFLAGS I needed to add -I${PS3DEV}/portlibs/ppu/lib/libzip/include so it'd find the zipconf.h header file.
   That's the correct installation location for the zipconf.h header.

  **Installation**

   If this is the first time installing, you need to make sure you have the dependencies installed.
   For a debian-based linux system, use the following:

    sudo apt-get install autoconf automake bison cmake flex gcc libelf-dev make \
    makedepend texinfo libncurses5-dev patch python subversion wget zlib1g-dev \
    libtool-bin python-dev bzip2 libgmp3-dev pkg-config libedje-bin libeet-bin \
    libssl-dev python-libxml2 xutils-dev

   You also need to install Cg Toolkit from nVidia. Go to the Cg Toolkit webpage:

    https://developer.nvidia.com/cg-toolkit-download
   Download Cg Toolkit 3.1. If you have a 32-bit system, download the 32-bit tgz if you feel up to manually
   copying the files into your system, or download the deb and use gdebi to install if you aren't comfortable
   with that. If you have a 64-bit system, download the 64-bit tgz. Don't download the deb file since this
   version has an issue with copying the files - the cg-toolkit is old enough that it uses /usr/lib64 for
   64-bit linux; that changed quite a while back, so you'll need to copy over all the files except the libs,
   then copy the libs from the archive into /usr/lib instead of /usr/lib64. You cannot use the deb file since
   it will copy the libs to the wrong directory. I suggest using an actual file manager such as Worker, which
   is in the Ubuntu repos. To copy files into /usr, run the file manager in super mode, like this:
    sudo worker

   If you have previously built the toolchain, backup your current version:

    mv ${PS3DEV} ${PS3DEV}.backup
   That way if something goes wrong, you can simply rm -rf ${PS3DEV} and then mv ${PS3DEV}.backup ${PS3DEV}.

   Setup your environmental variables:

    nano -w ~/.bashrc
    export PS3DEV=/usr/local/ps3dev
    export PSL1GHT=$PS3DEV/psl1ght
    export PATH=$PATH:$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin:$PSL1GHT
   Save the file, logout and log back in. A couple notes on this - making the .bashrc file means that everytime you
   open the terminal, the exports will be done. If you don't want this for some reason, save the exports into a plain
   text file and cut-and-paste them into the terminal before you try to build the toolchain or other PS3 projects.
   Also, I prefer to put all my toolchains into /opt/toolchains rather than /usr/local. There's nothing wrong with
   either, it's just a personal preference. So if you wish to use /opt/toolchains, the line from above would instead
   be

    export PS3DEV=/opt/toolchains/ps3dev

   Clone the repository and execute toolchain.sh

    git clone https://github.com/ChillyWillyGuru/toolchain.git
    cd toolchain
    ./toolchain.sh

  If there is a package you don't want installed, a chmod -x (script name) in the script directory should prevent it
  from executing.  If not, simply remove the script from the directory.  Certain packages depend on other packages
  so unless you know what you are doing, I highly suggest you only disable ps3elf and maybe one of the SDL2 if you
  do not need it.  If there's anything you want added, let me know.
