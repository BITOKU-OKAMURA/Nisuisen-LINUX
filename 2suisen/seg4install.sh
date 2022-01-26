#!/bin/bash
pwd=`pwd`
. $pwd/config/environment
export HDD="/dev/sdb"
#export configure_opt=$(cat $JOBDIR/.compile_option)

if [ "$1" != "" ];then
    seg4pkg $1
    exit $?
fi

for line_aegs in $(cat ./config/SAGYOU.list);do
    #vi $JOBDIR/config/$line_aegs.2suisen
    seg4pkg $line_aegs
done
