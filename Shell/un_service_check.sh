#/bin/sh
. /etc/profile
command=/tmp/command
rm -f $command
/usr/bin/find /service/*|/usr/bin/xargs svstat > $command
while read line_args ;do
sec=$(echo $line_args |cut -d " " -f 5)
name=$(echo $line_args |cut -d "/" -f 3|cut -d ":" -f1)
status=$(echo $line_args |cut -d " " -f 2)
if [[ $status != "up" ]] || [[ $sec -le 10 ]] ;then
echo "$name service NG" 
exit
fi
done < $command
echo "OK"
rm -f $command
exit
