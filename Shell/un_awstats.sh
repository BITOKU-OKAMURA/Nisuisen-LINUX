#!/bin/sh
. /etc/profile
awstatus(){
    Domain="$1"
    Nginx_LogDir="/var/log/nginx"
    HTML_DIR=/var/www/html
    [ ! -f $Nginx_LogDir/$Domain.log ] && return 9
    [ ! -f /usr/etc/awstats/awstats.$Domain.conf ] && return 9
    nice -19 /usr/local/awstats/wwwroot/cgi-bin/awstats.pl -update -config=$Domain 
    return 0
}
for logline in $(find /var/log/nginx -name "*.vps.log");do
    awstatus $(basename $logline|sed s/\.vps\.log//g)
done
exit 0
