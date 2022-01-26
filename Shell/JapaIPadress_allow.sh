#!/bin/sh
. /etc/profile
/bin/rm -f /ulib/jobtxt/cidr.txt.gz
cd /ulib/jobtxt || exit 9
wget http://nami.jp/ipv4bycc/cidr.txt.gz || exit 9
[ -f /ulib/jobtxt/cidr.txt.gz ] || exit 9
/bin/rm -f /ulib/jobtxt/JapanIP.txt
echo "" > /ulib/jobtxt/JapanIP.txt
for line_args in $(zcat ./cidr.txt.gz|grep "JP"|awk {'print $2'});do
echo "iptables -A INPUT -p tcp -m multiport --dports 20,21,22 -s \"$line_args\" -j ACCEPT" >> /ulib/jobtxt/JapanIP.txt
echo "iptables -A INPUT -p udp -m multiport --dports 20,21,22 -s \"$line_args\" -j ACCEPT"  >> /ulib/jobtxt/JapanIP.txt
done
/bin/rm -f /ulib/jobtxt/cidr.txt.gz*
