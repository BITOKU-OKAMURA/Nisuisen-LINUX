#!/bin/bash
#set -h
#-------------------------------------------------------------------------------
# The Nisuisen Linux 0.1(Mutsuki) Installer
# 2010 12.23 Segmentation 4LT LLC
#-------------------------------------------------------------------------------
. ./config/environment
Welcome
printf "It's install program of \""
green_color "Nisuisen Linux"
printf "\"\nTo proceed to the next procedure \n\
[Enter] key be pushd.";read Input

Welcome
blue_color "Disk device selection screen";enter

Welcome
blue_color "Internet connect Check";enter
ping -c2 www.defense.gov >/dev/null 2>&1
if [ $? -ne 0 ];then
    red_color "Internet connection Failed.";enter
    echo "To perform the installation must be connected to the Internet."
    echo "Please run this program after you have made to make the connection."
    exit 9
fi
printf "Internet connection ";blue_color "Complete";enter
sleep 3

export configure_opt="CFLAGS=\"-O3 -march=native\""
if [ ! -f ./.compile_option ];then
    Welcome
    blue_color "Compile Option Input";enter
    echo "enter a compile option when compiling the package.";enter
    echo "(Example):CC='gcc -O3 -march=nocona -m64 -msse -msse2 -msse3  -m128bit-long-double -mno-fp-ret-in-387 -fopenmp'"
    printf "(CompileOption):";read Input
    [ "$Input" != "" ] && echo $Input > $JOBDIR/.compile_option
    unset $Input
else
    export configure_opt=$(cat $JOBDIR/.compile_option)
fi
disk_args=$(fdisk -l|grep "Disk"|grep -v "identifier"|wc -l)
unset instdev
while [ 1 ] ;do
    Welcome
    blue_color "SELECT INSTALL HARD DISK ";printf "\n\n"
    score=0
    unset Input
    while [ $score -lt $disk_args  ];do
        score=`expr $score + 1`
        printf "No.$score :"
        echo $(fdisk -l|grep "Disk"|grep -v "identifier"|head -$score|tail -1)
    done
    printf "\nAfter entering the number of disk units to be set up,\
    \n[Enter] Please press a key[1-$score]";read Input
    [ $score -lt $Input  ] && continue
    [ "$Input" == "" ] && continue
    instdev=$(fdisk -l|grep "Disk"|grep -v "identifier"|head -$Input|tail -1|cut -d":" -f1|awk {'print $2'})
    [ "$instdev" == "" ] && continue
    [ -b $instdev ] || continue
    Welcome
    blue_color "$instdev";echo " to install the selected hard disk"
    enter
    echo "Please define logical partition in the region."
    echo "The contents should be defined are as follows."
    enter
    echo "1) $instdev$one is 64M bytes or more. System ID No. 83 (/boot)"
    echo "2) $instdev$two is 1G byte or more. logical. System ID No. 82 (swap)"
    echo "3) $instdev$tree is 6G bytes or more. System ID No. 83 (/)"
    enter
    echo "Described as an example the following line that can be installed with minimal configuration."
    echo "----------------------------------------------------------------------------"
    echo "   Device Boot      Start         End      Blocks   Id  System"
    echo "$instdev$one               1           9       72261   83  Linux"
    echo "$instdev$two              10         141     1060290   82  Linux swap / Solaris"
    echo "$instdev$tree             142         795     5442148   83  Linux"
    enter
    printf "[Enter] key to run fdisk for ";blue_color "$instdev";read $Input
    Welcome
    blue_color "FDISK for $instdev";enter
    logical_check=0
    while [ ! $logical_check -eq 3 ];do
        fdisk $instdev
        Welcome
        blue_color "$instdev";printf " logical partition check";enter;enter
        boot_byts=$(fdisk -l |grep "$instdev$one"|awk {'print $4'})
        boot_type=$(fdisk -l |grep "$instdev$one"|awk {'print $5'})
        [ "$boot_byts" == "" ] && boot_byts=0
        swap_byts=$(fdisk -l |grep "$instdev$two"|awk {'print $4'})
        swap_type=$(fdisk -l |grep "$instdev$two"|awk {'print $5'})
        [ "$swap_byts" == "" ] && swap_byts=0
        root_byts=$(fdisk -l |grep "$instdev$tree"|awk {'print $4'})
        root_type=$(fdisk -l |grep "$instdev$tree"|awk {'print $5'})
        [ "$root_byts" == "" ] && root_byts=0
        boot_byts=$(echo $boot_byts|sed 's@+@@g')
        swap_byts=$(echo $swap_byts|sed 's@+@@g')
        root_byts=$(echo $root_byts|sed 's@+@@g')

        if [ 72261 -le $boot_byts ]&&[ "$boot_type" == "83" ];then
            printf "($instdev$one)boot partition check.... ";green_color "OK";enter
            logical_check=`expr $logical_check + 1`
        else
            printf "($instdev$one)boot partition check.... ";red_color "NG";enter
        fi
        if [ 1060290 -le $swap_byts ]&&[ "$swap_type" == "82" ];then
            printf "($instdev$two)swap partition check.... ";green_color "OK";enter
            logical_check=`expr $logical_check + 1`
        else
            printf "($instdev$two)swap partition check.... ";red_color "NG";enter
        fi
        if [ 5442148 -le $root_byts ]&&[ "$root_type" == "83" ];then
            printf "($instdev$tree)root partition check.... ";green_color "OK";enter
            logical_check=`expr $logical_check + 1`
        else
            printf "($instdev$tree)root partition check.... ";red_color "NG";enter
        fi
        if [ $logical_check -ne 3 ];then
            printf "Because the install does not meet the requirements, \
                                       \nplease go to change the logical partition"
            logical_check=0
        fi
    done
    echo "So you're ready to begin installation."
    enter
    unset Input
    yellow_color "NOTICE:";echo "The initial spelling of the superuser password is [root]"
    echo "If you want the default and enter a different password here.";enter
    printf "[Enter] Please press a key";read Input
    if [ "$Input" == "" ];then
        export root_passwd="root"
    else
        export root_passwd=$Input
    fi
    echo $root_passwd > $JOBDIR/.root_passwd
    Welcome
    blue_color "1.HARD DISK FORMAT";printf "\n\n"
    Command "/boot ext2 Format" "mkfs.ext2 $instdev$one"
    Command "swap Format" "mkswap $instdev$two" 
    Command "/ ext4 Format" "mkfs.ext4 $instdev$tree"
    export HDD=$instdev
    for line_aegs in $(cat ./config/SAGYOU.list);do
        seg4pkg $line_aegs 
    done
    . ./config/environment
    for line_aegs in $(cat ./config/SAGYOU.list);do
        seg4pkg $line_aegs
        sync && echo 3 > /proc/sys/vm/drop_caches
    done
    cd $LFS/usr/src && tar xpf ./linux-2.6.35.9.tar.bz2
    cd $LFS/usr/src/linux-2.6.35.9 && make mrproper
    cd $LFS/usr/src/linux-2.6.35.9 && rm -f ./config-2.6.35
    cd $LFS/usr/src/linux-2.6.35.9 && wget http://seg4.jp/src/config-2.6.35.gz
    cd $LFS/usr/src/linux-2.6.35.9 && gzip -d ./config-2.6.35.gz
    cd $LFS/usr/src/linux-2.6.35.9 && cp -pf ./config-2.6.35 ./.config
    cd $LFS/usr/src/linux-2.6.35.9 && $JOBDIR/config/oldmake.sh
    cd $LFS/usr/src/linux-2.6.35.9 && sed -i 's@-O2@-O3 -mtune=native@g' ./Makefile
    seg4pkg linux-2.6.35.9
    root=$(cat $JOBDIR/.root_passwd)
    /bin/expect -c "
        set timeout 7200
        spawn chroot $LFS /bin/env -i HOME=/root TERM=$TERM PS1=2suisen# LC_ALL=POSIX TZ=$TZ+15 /bin/sh
        expect 2suisen#
        send \"passwd\n\"
        while {1} {
            expect {
               \"password: \" { send \"$root\n\" }
               \"2suisen#\" {break}
            }
        }
        send \"exit\n\"
    "
    echo $configure_opt > $LFS/etc/make.conf
    echo "nameserver 210.130.0.1"  > $LFS/etc/resolv.conf
    mkdir -p $LFS/root/.2suisen/config
    /bin/cp -p $JOBDIR/config/*.2suisen $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/*.patch $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/*.sh $LFS/root/.2suisen/config/
    /bin/cp -p $JOBDIR/config/environment.3rd $LFS/root/.2suisen/config/environment
    echo ". /etc/profile" > $LFS/root/.bash_profile

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
    test -f $LFS/root/.2suisen/error.log && exit 9
done
    /bin/rm -Rf /mnt/lfs/usr/src/* 
    set timeout 7200
    /bin/expect -c "
        spawn chroot $LFS /bin/sh
        expect sh-4.1#
        send \"find /{,usr/,usr/X11/,usr/i686-pc-linux-gnu/}{bin,sbin} -type f  -exec strip --strip-all '{}' ';' >/dev/null 2>&1\n\"
        expect sh-4.1#
        send \"find /{,usr/,usr/X11/,usr/i686-pc-linux-gnu/}lib -type f  -exec strip --strip-debug '{}' ';' >/dev/null 2>&1\n\"
        expect sh-4.1#
        send \"exit\n\"
    "











    break
done
