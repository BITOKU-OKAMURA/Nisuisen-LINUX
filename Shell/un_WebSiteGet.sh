#!/bin/sh

job_FailedEnd(){
/bin/rm -Rf $LineDir/*
printf "ERROR" > $LineDir/../result/$Token.result
exit 9
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


/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 wget \
--recursive \
--no-clobber \
--page-requisites \
-H \
-l 4 \
-E \
-k \
--random-wait \
--accept htm,html,jpg,jpeg,png,gif,css*,txt,css \
--ignore-tags=script,embed,object \
lnoclobber=on \
--html-extension \
--restrict-file-names=nocontrol \
--domains $DOMAIN,md.exblog.jp,image.excite.co.jp,stat.ameba.jp,stat100.ameba.jp,blogimg.jp,blogsys.jp,blog-imgs-1-origin.fc2.com,blog-imgs-1.fc2.com,blog-imgs-24.fc2.com,blog-imgs-27.fc2.com,blog-imgs-29.fc2.com,blog-imgs-36-origin.fc2.com,blog-imgs-36.fc2.com,blog-imgs-37-origin.fc2.com,blog-imgs-37.fc2.com,blog-imgs-38-origin.fc2.com,blog-imgs-38.fc2.com,blog-imgs-42-origin.fc2.com,blog-imgs-42.fc2.com,blog-imgs-43-origin.fc2.com,blog-imgs-44-origin.fc2.com,blog-imgs-44.fc2.com,blog-imgs-45-origin.fc2.com,blog-imgs-46-origin.fc2.com,blog-imgs-46.fc2.com,blog-imgs-47-origin.fc2.com,blog-imgs-47.fc2.com,blog-imgs-48-origin.fc2.com,blog-imgs-48.fc2.com,blog-imgs-49-origin.fc2.com,blog-imgs-49.fc2.com,blog-imgs-50-origin.fc2.com,blog-imgs-50.fc2.com,blog-imgs-51-origin.fc2.com,blog-imgs-51.fc2.com,blog-imgs-52-origin.fc2.com,blog-imgs-52.fc2.com,blog-imgs-53-origin.fc2.com,blog-imgs-53.fc2.com,blog-imgs-54-origin.fc2.com,blog-imgs-54.fc2.com,blog-imgs-55-origin.fc2.com,blog-imgs-55.fc2.com,blog-imgs-56-origin.fc2.com,blog-imgs-56.fc2.com,blog-imgs-57-origin.fc2.com,blog-imgs-57.fc2.com,blog-imgs-58-origin.fc2.com,blog-imgs-58.fc2.com,blog-imgs-60-origin.fc2.com,blog-imgs-60.fc2.com,blog-imgs-61-origin.fc2.com,blog-imgs-61.fc2.com,blog-imgs-62-origin.fc2.com,blog-imgs-62.fc2.com,blog-imgs-63-origin.fc2.com,blog-imgs-63.fc2.com,blog-imgs-64-origin.fc2.com,blog-imgs-64.fc2.com,blog-imgs-65-origin.fc2.com,blog-imgs-65.fc2.com,blog-imgs-66-origin.fc2.com,blog-imgs-66.fc2.com,blog-imgs-67.fc2.com,blog-imgs-68-origin.fc2.com,blog-imgs-68.fc2.com,blog-imgs-69-origin.fc2.com,blog-imgs-69.fc2.com,blog-imgs-70-origin.fc2.com,blog-imgs-70.fc2.com,livedoor.blogimg.jp,static.fc2.com,parts.blog.livedoor.jp,img.blog.livedoor.com,livedoor.blogimg.jp ,d.st-hatena.com \
--user-agent="Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/30.0.1500.00 Mobile/10BFFF Safari/9999.99" \
$NO_PART $URL > /dev/null 2>&1
[ `find $DOMAIN/* -name "*.htm*"|wc -l` -eq 0 ] && job_FailedEnd
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
