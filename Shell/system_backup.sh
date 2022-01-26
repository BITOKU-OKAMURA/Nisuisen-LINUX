#!/bin/sh
cd / || exit $?
nice -19 tar czpvf /var/backup/system-backup.$(date +%Y%m%d).tar.gz /bin /boot /command /etc /lib /root /sbin /usr || exit $?
#ls -lta /var/backup/*.gz|tail -1|awk {'print $8,$9'} |xargs /bin/rm -f 
tmpwatch -m 2200 -d /var/backup/
exit $?
