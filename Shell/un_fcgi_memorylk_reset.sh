#/bin/bash
. ~/.bash_profile
for line in $(ps -aelwFT|grep -v "grep"|grep  /home/sdl/devel/obj-c/cgiExecute|awk {'print $4,$13'}|sed -e 's@ @#@g');do
pid=$(echo $line|cut -d "#" -f1)

cat


memory=$(echo $line|cut -d "#" -f2)
if [[ "$(echo $memory|sed -e 's/[0-9]//g')" != "" ]] || [[ $memory -ge 7999 ]] ;then
#リークがやばいのでFCGIを再起動
fi

done




