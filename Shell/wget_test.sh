#!/bin/sh

job_FailedEnd(){
/bin/rm -Rf $LineDir/*
printf "ERROR" > $LineDir/../result/$Token.result
exit 9
}
hyakupaa(){
exit 0
}
export JOBNAME=`basename $0`
cd `echo $0 |sed  "s/$JOBNAME//g"` && JOBDIR=`pwd`
export ULIB=$JOBDIR/../
. $ULIB/jobcom/com_environment
. $JOBTXT/xalande_webget_setting.txt
#--no-parent
export URL=$3
export LineDir=$1
export Token=$2
[ "$URL" = "" ] && exit 9
#[ "$Token" = "" ] && exit 9
#[ -f "$LineDir/$Token.trigger" ] || exit 9

line=`basename $LineDir`
DOMAIN=$(echo $URL |cut -d "/" -f 3-|cut -d "/" -f 1)
CSSHTML=/tmp/load_css.$$
EXECDIR=/home/sdl/GNUstep/LOCAL_HTML/wget_contents/
NO_PART=""
[ "$(basename $URL)" = "$DOMAIN" ] || NO_PART="--no-parent"
[ "$DOMAIN" = "" ] && job_FailedEnd
cd $LineDir  || job_FailedEnd

#echo "NO_PART=$NO_PART"
#echo URL=$URL
#echo LineDir=$LineDir
#echo  Token=$Token
#echo  Domain=$DOMAIN


RET=0
[ `df -hT |grep $line|awk {'print $6'}|cut -d "%" -f1` -eq 100] && hyakupaa
[ $RET -ne 0 ] && [ $RET -ne 4 ]  && job_FailedEnd
/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 find $DOMAIN/* -name "*.htm*"|xargs grep -E "<*.stylesheet.*.\.css.*"|cut -d ":" -f 2-|sort |uniq|sed -e 's/></>\m</g' >> $CSSHTML
while read line_args ;do
lc_filePath=`echo $line_args|cut -d "/" -f 3- |cut -d "\""  -f1`
lc_basename=`echo $lc_filePath|xargs basename`
lc_dir=`eval "echo $lc_filePath|sed 's@$lc_basename@@g'"`
lc_savename=`echo $lc_basename|cut -d "?" -f 1`
mkdir -p $lc_dir || break
cd $lc_dir
wget http://$lc_filePath -O ./$lc_savename  > /dev/null 2>&1
cd $LineDir  || break
done < $CSSHTML
/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 find $DOMAIN/* -name "*.htm*"|xargs grep -E "<*.stylesheet.*.\.css.*"|cut -d ":" -f 1|sort |uniq|xargs sed -i "s/\.css?.*.\"/$1\.css/g"  > /dev/null 2>&1
/bin/rm -f $CSSHTML

ZipList=`ls -la |grep -E "^drw"|awk {'print $9'}|grep -E "^[a-zA-Z]"`
/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 zip -r $LineDir/../archive/$Token.zip `echo $ZipList`  > /dev/null 2>&1
rm -Rf ./*
[ -f $LineDir/../archive/$Token.zip ] && printf "REATY" > $LineDir/../result/$Token.result
exit
