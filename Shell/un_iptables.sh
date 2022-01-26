#!/bin/dash
. /etc/profile
iptables -F
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p udp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p udp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -p udp --dport 25 -j ACCEPT
#iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#iptables -A INPUT -p udp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p udp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 465 -j ACCEPT
iptables -A INPUT -p udp --dport 465 -j ACCEPT
iptables -A INPUT -p tcp --dport 995 -j ACCEPT
iptables -A INPUT -p udp --dport 995 -j ACCEPT
iptables -A INPUT -p tcp --dport 161 -j ACCEPT
iptables -A INPUT -p udp --dport 161 -j ACCEPT
iptables -A INPUT -p tcp --dport 162 -j ACCEPT
iptables -A INPUT -p udp --dport 162 -j ACCEPT
#iptables -A INPUT -p udp --dport 8081 -j ACCEPT
#iptables -A INPUT -p tcp --dport 8081 -j ACCEPT
iptables -A OUTPUT -s 127.0.0.1 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -s 192.168.0/16 -j ACCEPT
iptables -A INPUT -s 192.168.0/16  -j ACCEPT
iptables -A FORWARD -s 192.168.0/16  -j  ACCEPT
iptables -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
iptables -A INPUT -p icmp --icmp-type source-quench -j ACCEPT
iptables -A INPUT -p icmp --icmp-type redirect -j ACCEPT
iptables -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
iptables -A INPUT -p icmp --icmp-type parameter-problem -j ACCEPT
. /ulib/jobtxt/JapanIP.txt
#iptables -A FORWARD -i eth4 -o ppp0 -s 192.168.0/16 -j ACCEPT
#iptables -A FORWARD -i ppp0 -o eth4 -s 192.168.0/16 -j ACCEPT
#iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
#iptables -A INPUT -p icmp --icmp-type any -j ACCEPT
#iptables -A OUTPUT -p icmp --icmp-type any -j ACCEPT
#DROP LIST -Linode, LLC-
#iptables -A OUTPUT -s 106.186.112.0/24 -j DROP
#iptables -A INPUT -s 106.186.112.0/24 -j DROP
