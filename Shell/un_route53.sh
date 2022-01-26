#!bin/bash
. /etc/profile >/dev/null 2>&1
CURRENTMACHINEIP=$(wget http://www.ugtop.com/spill.shtml  -O -|sed 's/>/>\n/g'|sed "s/<[^>]*>//g"|grep -E "^[0-9]*.\..*"|head -1)
NOW_GATEWEBIP=$(dig @210.130.0.1 dairiten.gateweb.me.uk|grep -E "*.IN.*.A"|grep dairiten.gateweb.me.uk|tail -1|awk '{print $5}')
test "$NOW_GATEWEBIP" = "$CURRENTMACHINEIP" && exit 5
eval "cat /ulib/jobtxt/route53.txt |sed s'@### IP ###@$CURRENTMACHINEIP@g'" > /tmp/toute53.json || exit 9
/usr/local/bin/aws route53 change-resource-record-sets --hosted-zone-id "ZDU4NK7GDQX81" --change-batch  file:///tmp/toute53.json || exit 9
/bin/rm -f /tmp/toute53.json
exit 0
