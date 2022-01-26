#!/bin/sh
export JOBNAME=`basename $0`
cd `echo $0 |sed  "s/$JOBNAME//g"` && JOBDIR=`pwd`
export ULIB=$JOBDIR/../
. $ULIB/jobcom/com_environment
. $JOBTXT/xalande_webget_setting.txt
com_jobstart
for line in `cat /var/log/nginx/gateweb.dip.jp.log|grep -E "*.GET.*./XaLande/kuraudo/archive/.*.\.zip.*.HTTP/.*.200.*"|cut -d "\"" -f 2|cut -d " " -f 2|sort|uniq` ;do rm -f /home/sdl/gateweb.dip.jp$line ;done
chmod 666 $KURAUDO_DIR/xl_recive.cgi
touch $JOBTXT/_MachiAwase.txt
#for line_args in $(cat $JOBTXT/MachiAwase.txt) ; do
while read line_args ;do
#使用していないラインを選定
ResponceLine=0;
for num in 1 2 3 4 ;do
if [ $(find $KURAUDO_DIR/line$num/ -type f -name "*.trigger"|wc -l) -eq 0 ] ;then
ResponceLine=$num
break
fi
done
# 0じゃないならラインに乗せる
if [ $ResponceLine -ne 0 ];then

token=$(echo $line_args|cut -d "<" -f1)
get_url=$(echo $line_args|cut -d ">" -f2)
com_debug "Line=$ResponceLine Token=$token URL=$get_url"
touch $KURAUDO_DIR/line$ResponceLine/$token.trigger
eval "/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 $JOBLIB/un_WebSiteGet.sh \"$KURAUDO_DIR/line$ResponceLine/\" \"$token\" \"$get_url\"" &

else
echo $line_args >> $JOBTXT/_MachiAwase.txt
fi
done < $JOBTXT/MachiAwase.txt
mv $JOBTXT/_MachiAwase.txt $JOBTXT/MachiAwase.txt
chmod 755 $KURAUDO_DIR/xl_recive.cgi
com_jobcomplete

