#!/bin/bash
cd /home/sdl/GNUstep/Xcodeプロジェクト/ || exit 9
for line in $(ls -l ./ |grep -v "Backup"|grep -E "^drwx"|awk {'print $9'});do
eval "./XcodeBKUP.sh $line"
done
