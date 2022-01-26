#!/bin/sh
##
##sed -i 's@_GL_WARN_ON_USE (gets, "gets is a security hole - use fgets instead");@//_GL_WARN_ON_USE (gets, "gets is a security hole - use fgets instead");@g' gnu/stdio.in.h
##
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export EX_CFLAGS=" -Os -m64 -mtune=nocona -march=nocona -ltinfo "
export FORCE_UNSAFE_CONFIGURE=1
alias make='make -j3'
install(){
    if [[ $ARGS_2nd == "1st" ]];then
        eval "make install DESTDIR=/mnt/lfs"
    else
        eval "make install"
    fi
}

StepOfExecute(){
    Execute=$1
    CMD_LINE=$(cat $ULIB/Configure/$ARGS_2nd/$ARGS_1st*.2suisen|grep -e "^$Execute:"|cut -d ":" -f 2-)
    if [[ $Execute == "configure" ]];then
        #Configre
        [[ $CMD_LINE == "" ]] && return 0
        eval "CFLAGS=\"$EX_CFLAGS\" ../$AppName/$configure_dir/configure $CMD_LINE " 1>/dev/null 
        return $?
    else
        [[ $CMD_LINE == "" ]] || eval "$CMD_LINE" 1>/dev/null
        return $?
    fi
}
JOBNAME=`basename $0`
cd `echo $0 |sed  "s/$JOBNAME//g"` && JOBDIR=`pwd`
ULIB=$JOBDIR/../
find ../src/$1* -name "*.xz"|xargs xz -d 
cd $ULIB/Builed && cd $(find $ULIB/src/$1* 2>/dev/null |xargs tar xvf 1>./out.txt 2>/dev/null && head -1 ./out.txt|cut -d "/" -f 1) && rm -f ../out.txt
[[ $(basename $PWD) == "Builed" ]] && echo "SmeIPPAI" && exit 9
AppName=`basename $PWD`
ARGS_2nd=$2
ARGS_1st=$1
[[ $ARGS_2nd == "" ]] && exit 9
mkdir -p ../build && cd ../build
CurrentDir=$PWD

for line_args in prescript configure make postscript ;do
    StepOfExecute $line_args || exit 9
done

#ConfigFileRename
Filename=$(find $ULIB/Configure/$ARGS_2nd/* -type f -name "$ARGS_1st*.2suisen")
[[ -f $Filename ]] && [[ $(grep -c 'djb-ccerror.sh' $Filename) -eq 0 ]] && mv $Filename $ULIB/Configure/$ARGS_2nd/$AppName.2suisen  1>/dev/null 2>/dev/null

#Clean
cd $ULIB/Builed &&  rm -Rf ./build

