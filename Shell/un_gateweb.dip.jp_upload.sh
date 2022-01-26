#!/bin/sh
. /etc/profile
cd ~/gateweb.dip.jp
rm -f ./upload.tar.gz
LIST=$(find ./*.* -type f|grep -Ev "^mt")
tar czpvf ./upload.tar.gz ./blog ./XaLande $(echo $LIST) --exclude XaLande/kuraudo 
ftp -n gwc.name << _EOD
user webuser001 aknwaopfhwuaipqbheabfjavbhudspifdsafdjklhue8792hruk32fkhf78
binary
cd ~/
lcd /home/sdl/gateweb.dip.jp
put ./upload.tar.gz
bye
_EOD
exit 0
