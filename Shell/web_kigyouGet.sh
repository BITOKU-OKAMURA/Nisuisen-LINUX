#!/bin/bash
func_shinzouget(){
cd $1 || return
URL="http://$1"
wget $URL || return
mv $(ls -ltra|tail -1|awk {'print $9'}) index.html
}
#----------------------------------------------------
# クリーニング
#----------------------------------------------------
WGET_DIR=/tmp/wget
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
--domains kigyousupport.tokyo \
--user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1);" http://kigyousupport.tokyo/ > /dev/null 2>&1

find * -type f -name "*.html"|cut -d "." -f -2|xargs mkdir -p
find * -type f -name "*.html"|xargs rm -f
current=$(pwd)
for line_args in $(find * -type d|grep -v "wp-"|grep -v "comments"|grep -v "feed");do
func_shinzouget "$line_args"
cd $current
done
cd $current
mkdir -p ./kigyousupport.tokyo/result
func_shinzouget "kigyousupport.tokyo/result"
cd $current
find * -name "*.jpg"|xargs tar rvf atchive.tar
find * -name "*.gif"|xargs tar rvf atchive.tar
find * -name "*.png"|xargs tar rvf atchive.tar
find * -type d -name "wp-*"|xargs rm -Rf
tar xf atchive.tar && rm -f atchive.tar

#----------------------------------------------------
# 空白対策 と展開
#----------------------------------------------------
for line_args in $(find * -type f -name "*.html");do
sed -i "s///g" $line_args
#sed -i "s/<\/head>/<meta name=\"ROBOTS\" content=\"NOINDEX,NOFOLLOW\"><\/head>/g" $line_args
done
exit
