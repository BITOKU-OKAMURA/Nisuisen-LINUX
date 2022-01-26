#!/bin/bash

#----------------------------------------------------
# クリーニング
#----------------------------------------------------
HTML_DIR=/home/sdl/0/gateweb.dip.jp
WGET_DIR=/tmp/wget
cd $HTML_DIR
find ./* -name "*.html"|grep -v "XaLande"|grep -v "www.ookamicapital.com"|grep -Ev "^./wp-content"|grep -Ev "\./blog" |xargs rm -f 
[[ $1 == "del" ]] && exit 9
#----------------------------------------------------
# HTML作成
#----------------------------------------------------
mkdir -p $WGET_DIR && cd $WGET_DIR
/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 wget \
--recursive \
--no-clobber \
--page-requisites \
num_tries = 3 \
-H \
-l 0 \
-E \
-k \
--random-wait \
lnoclobber=on \
--html-extension \
--trust-server-names \
--restrict-file-names=nocontrol \
--domains gateweb.dip.jp \
--user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1);" http://gateweb.dip.jp/ > /dev/null 2>&1
#----------------------------------------------------
# 空白対策 と展開
#----------------------------------------------------
cd ./gateweb.dip.jp
LIST="$(find ./* -name "feed") $(find ./* -name "*.htm*"|grep -Ev "^./XaLande")"
for line_args in $LIST;do
sed -i "s/<div class=\"info-bar\" style=\"background-image:url( '/\n<div class=\"info-bar\" style=\"background-image:url( '/g" $line_args
SAKUJYO="$(cat $line_args |grep map-21|cut -d "'" -f2-|cut -d " " -f1) /"
sed -i "s@$SAKUJYO@/@g" $line_args
sed -i "s@action=\"index.html\"@action=\"index.php\"@g" $line_args
sed -i "s///g" $line_args
done
chown -R 2:16 ../gateweb.dip.jp
tar czpvf ../gateweb.tar.gz $LIST
cd $HTML_DIR
tar xf $WGET_DIR/gateweb.tar.gz
rm -Rf $WGET_DIR/*
exit
