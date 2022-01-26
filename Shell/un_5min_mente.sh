#!/bin/sh
. /etc/profile >/dev/null 2>&1
#/ulib/joblib/un_machiawase.sh  >/dev/null 2>&1 &
#/usr/bin/ionice -c 2 -n 7 /bin/nice -19 sync >/dev/null 2>&1
#/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 du -am /etc >/dev/null 2>&1 &
#/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 du -am /usr >/dev/null 2>&1 &
#/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19 du -am /var >/dev/null 2>&1 &
chown -R vpopmail.vchkpw /mnt/home/vpopmail && /home/vpopmail/bin/clearopensmtp >/dev/null 2>&1
if [ $(free |grep Swap|awk {'print $3'}) -ne 0 ] ;then
    sync; echo "1" > /proc/sys/vm/drop_caches
    sync; echo "2" > /proc/sys/vm/drop_caches
    sync; echo "3" > /proc/sys/vm/drop_caches
fi
/usr/bin/ionice -c 2 -n 7 /bin/nice -n 19  ntpdate ntp.jst.mfeed.ad.jp || /usr/bin/ionice -c 2 -n 7 /bin/nice -n 19  ntpdate time.nist.gov
chown -R sdl.wheel /home/sdl
#chown -R sdl.wheel /mnt/home/sdl
chown -R nobody.nogroup /home/sdl/devel/*/storage
chown -R nobody.nogroup /home/sdl/devel/*/Log/*.*
chown -R postgres.postgres /usr/local/pgsql
chown -R nobody.nogroup /home/sdl/0/*/wp-content
chmod -R 777 /home/sdl/0/*/wp-content
#chown -R nobody.nogroup /home/sdl/devel/Dairiten/templates_c
chown -R nobody.nogroup /home/sdl/devel/Dairiten/webroot
chown -R nobody.nogroup /home/sdl/devel/K-PlatForm/webroot
chown -R nobody.nogroup /home/sdl/0/k-pra.web-x.co.jp/image
#chmod 777 /home/sdl/devel/Dairiten/templates_c
#chmod 666 /home/sdl/devel/Dairiten/templates_c/*
chmod -R 777 /home/sdl/devel/Dairiten/webroot/*
chmod -R 777 /home/sdl/devel/K-PlatForm/webroot/*
touch /tmp/fcgi_temp/cgi.sock
touch /tmp/fcgi_temp/fcgi-phpfcgi.socket
touch /tmp/fcgi_temp/unicorn.sock
#for line_args in php-fpm nginx ;do [[ $(/bin/ps -ax |grep $line_args|awk {'print $3'}|grep -Ev "^S"|wc -l) -ne 0 ]] && rm -Rf /tmp/nginx_ploxy/* && svc -d /service/$line_args && sleep 1 && svc -u /service/$line_args ;done

#/ulib/joblib/un_route53.sh  >/dev/null 2>&1

chmod -R 707 /home/sdl/devel/SideBizzManage/webroot
chmod -R 707 /home/sdl/devel/SideBizzManage/Log

touch  /tmp/fcgi-phpfcgi7.3.socket
chmod 1777 /tmp/fcgi-phpfcgi7.3.socket



