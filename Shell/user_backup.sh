#!/bin/sh
. /root/.bash_profile
for ARGS in $(echo `ls -la /var/home_users/sdl |grep drw|grep -v lost+found |grep -v KABU|grep -v PC_Documents|grep -v backup|grep -v "\."|awk {'print $8'}`);do
DIR="$DIR /var/home_users/sdl/$ARGS"
done


cd /_backup || exit 9
nice -19 tar czpvf ./var-backup.$(date +%Y%m%d).tar.gz $DIR /var/seg4 /var/qmail || exit 9
ls -lta /_backup/*.gz|tail -1|awk {'print $8,$9'} |xargs /bin/rm -f
tmpwatch -m 2200 -d /var/backup/
