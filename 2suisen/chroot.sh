#!/bin/bash
export LFS=/mnt/lfs
mount /dev/sdb3 $LFS
mount /dev/sdb1 $LFS/boot
mkdir -p /mnt/lfs/dev
mkdir -p /mnt/lfs/proc
mkdir -p /mnt/lfs/sys
mkdir -p $LFS/var/run/
touch $LFS/var/run/utmp
touch $LFS/var/log/btmp
touch $LFS/var/log/lastlog
touch $LFS/var/log/wtmp
chgrp -v utmp $LFS/var/run/utmp $LFS/var/log/lastlog
chmod -v 664 $LFS/var/run/utmp $LFS/var/log/lastlog
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3
mount -v --bind /dev $LFS/dev
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys

