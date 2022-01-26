#!/bin/bash
. ~/.bash_profile
/usr/sbin/logrotate -f /etc/logrotate.conf
chown root.root /var/log/nginx/access_log && chmod 444 /var/log/nginx/access_log
#sync; echo "1" > /proc/sys/vm/drop_caches
#sync; echo "2" > /proc/sys/vm/drop_caches
#sync; echo "3" > /proc/sys/vm/drop_caches
#/usr/sbin/tmpwatch -x /tmp/.X11-unix -x /tmp/.XIM-unix -x /tmp/.font-unix \
#-x /tmp/.ICE-unix -x /tmp/.Test-unix 240 /tmp
#/usr/sbin/tmpwatch 720 /var/tmp
for d in /var/{cache/man,catman}/{cat?,X11R6/cat?,local/cat?}; do
  if [ -d "$d" ]; then
    /usr/sbin/tmpwatch -f 720 "$d"
  fi
done
#rm -f /home/sdl/F/svn_rep.tar.xz
#cd /var/svn || exit 9
#tar -Jcpf /home/sdl/F/svn_rep.tar.xz ./repos
#cd /usr/etc/cron.d && rm -f ./cron.tar.gz && tar czpvf cron.tar.gz /var/spool/cron
/usr/bin/find /home/sdl/devel/Dairiten/Log/ -type f -atime 30|xargs rm -f
#/usr/bin/setuidgid sdl /home/sdl/devel/Dairiten/Util/record_backup.sh

mkdir -p /tmp/sidebizz_v2 && chmod -R 1777 /tmp/sidebizz_v2
 
