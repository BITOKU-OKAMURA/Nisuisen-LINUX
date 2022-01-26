#!/bin/bash
. ~/.bash_profile
cd ~/blg.gwc.name
[ -f upload.tar.gz ] && rm -f upload.tar.gz
list=$(ls -la|awk {'print $8'}|grep -v COPYING| grep -v alt-tmpl| grep -v default_templates| grep -v extlib| grep -v import| grep -v lib| grep -v mt-atom.cgi| grep -v mt-check.cgi| grep -v mt-comments.cgi| grep -v mt-config.cgi-original| grep -v mt-feed.cgi| grep -v mt-ftsearch.cgi| grep -v mt-search.cgi|grep -v mt-tb.cgi| grep -v mt-testbg.cgi| grep -v mt-upgrade.cgi| grep -v mt-wizard.cgi| grep -v mt-xmlrpc.cgi| grep -v mt.cgi| grep -v php| grep -v plugins| grep -v readme.html| grep -v search_templates| grep -v tmpl| grep -v tool|grep -v "\."|grep -v db)
list="$list $(ls -la *.*|awk {'print $8'}|grep -v COPYING| grep -v alt-tmpl| grep -v default_templates| grep -v extlib| grep -v import|grep -v lib| grep -v mt-atom.cgi| grep -v mt-check.cgi| grep -v mt-comments.cgi| grep -v mt-config.cgi-original| grep -v mt-feed.cgi| grep -v mt-ftsearch.cgi| grep -v mt-search.cgi| grep -v mt-static| grep -v mt-tb.cgi| grep -v mt-testbg.cgi| grep -v mt-upgrade.cgi| grep -v mt-wizard.cgi| grep -v mt-xmlrpc.cgi| grep -v mt.cgi| grep -v php| grep -v plugins| grep -v readme.html| grep -v search_templates| grep -v tmpl| grep -v tool|grep -v cgi)"
echo $list
tar czpvf upload.tar.gz $list
ftp -n gwc.name << _EOD
user webuser001 aknwaopfhwuaipqbheabfjavbhudspifdsafdjklhue8792hruk32fkhf78
binary
cd ~/ 
lcd /home/sdl/blg.gwc.name
put ./upload.tar.gz
bye
_EOD

[ -f upload.tar.gz ] && rm -f upload.tar.gz
exit 0

