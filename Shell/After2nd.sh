#!/bin/bash
rm -Rf /seg4/Builed/*
cd /seg4/Builed
tar xpf ../src/linux-*.*
cd linux-*.*/
make mrproper
cp -p ../../Patchs/config-3.11.10-301.fc20.x86_64 ./.config
sed -i 's@CONFIG_NET_VENDOR_INTEL=y@CONFIG_NET_VENDOR_INTEL=n@' ./.config
sed -i 's@CONFIG_SECURITY_SELINUX=y@CONFIG_SECURITY_SELINUX=n@' ./.config
sed -i 's@CONFIG_REISERFS_FS=m@CONFIG_REISERFS_FS=y@' ./.config
sed -i 's/# CONFIG_EXT3_FS is not set/CONFIG_EXT3_FS=y\nCONFIG_EXT3_DEFAULTS_TO_ORDERED=y\nCONFIG_EXT3_FS_XATTR=y\nCONFIG_EXT3_FS_POSIX_ACL=y set\nCONFIG_EXT3_FS_SECURITY=y\n# CONFIG_JBD_DEBUG is not set/' ./.config
make oldconfig
sed -i 's@-O2@-Os -m64 -mtune=nocona -march=nocona@g' ./Makefile
make V=1
make modules_install
export KERNEL_VERTION=`basename $(pwd)|sed 's/[a-z]//g'`
cp -v arch/x86/boot/bzImage /boot/vmlinuz$KERNEL_VERTION-GateWeb
cp -v System.map /boot/System.map$KERNEL_VERTION
cp -v .config /boot/config$KERNEL_VERTION
install -v -m755 -d /etc/modprobe.d
cd / && find /{,usr/,usr/X11/,usr/x86_64-unknown-linux-gnu/}{bin,sbin} -type f -exec strip --strip-all '{}' ';' >/dev/null 2>&1
cd / && find /{,usr/,usr/X11/,usr/x86_64-unknown-linux-gnu/}{lib,lib64} -type f -exec strip --strip-debug '{}' ';' >/dev/null 2>&1
rm -Rf /seg4/src/* /seg4/Builed/*
