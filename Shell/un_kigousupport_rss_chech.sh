#!/bin/bash
. /etc/profile
GETRSSDATE=$(wget -O- http://jvn.jp/rss/jvn.rdf |grep "dc:date"|head -1|sed -e 's/<[^>]*>//g'|sed -e 's@ @@g'|cut -d "+" -f1|sed -e  's@T@ @g'|cut -d " " -f1)
TODAY=$(date +%Y-%m-%d)
[[ $GETRSSDATE == $TODAY ]] || exit 0
/ulib/joblib/sendmail.pl
exit 0
