#!/bin/sh
URL=$1
Packege=`basename $URL` || exit 9
cd ../RPM
RPMDIR=`pwd`
wget $URL
cd /mnt/lfs && rpm2cpio $RPMDIR/$Packege | cpio -id
