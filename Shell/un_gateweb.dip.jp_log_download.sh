#!/bin/sh
. /etc/profile
cd /var/log/nginx/
ftp -n gwc.name << _EOD
user webuser001 aknwaopfhwuaipqbheabfjavbhudspifdsafdjklhue8792hruk32fkhf78
ascii
cd /home/webuser001/
lcd /var/log/nginx/
get gateweb.dip.jp.vps.log
delete gateweb.dip.jp.vps.log
bye
_EOD

