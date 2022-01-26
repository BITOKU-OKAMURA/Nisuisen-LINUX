#!/bin/bash
export LFS=/mnt/lfs
export JOBDIR=~/2suisen
    mkdir -p $LFS/root/.2suisen/config
    echo "nameserver 210.130.0.1"  > $LFS/etc/resolv.conf
    cat $JOBDIR/.compile_option > $LFS/etc/make.conf
    /bin/cp -p $JOBDIR/config/*.2suisen $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/*.patch $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/*.sh $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/environment.3rd $LFS/root/.2suisen/config/environment

for line_aegs in $(cat ./config/SAGYOU.3rd);do

    sync && echo 3 > /proc/sys/vm/drop_caches
    /bin/expect -c "
        set timeout 7200
        spawn chroot $LFS /bin/sh
        expect sh-4.1#
        send \"cd ~/.2suisen\n\"
        expect sh-4.1#
        send \". ~/.2suisen/config/environment\n\"
        expect sh-4.1#
        send \"seg4pkg  $line_aegs\n\"
        expect sh-4.1#
        send \"exit\n\"
    "
done

