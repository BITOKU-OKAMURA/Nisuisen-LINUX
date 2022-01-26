#!/bin/bash
export PATH="/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/X11/bin:/root/.composer/vendor/bin"
svc -d /service/nginx
rm -Rf /tmp/nginx_ploxy
#rm -f /tmp/fcgi_temp/sess_*
find /tmp/fcgi_temp/templates_c/* -type f |xargs rm -f
mkdir -p /tmp/nginx_ploxy/temp
chown -R 1777 /tmp/nginx_ploxy/temp
svc -u /service/nginx



