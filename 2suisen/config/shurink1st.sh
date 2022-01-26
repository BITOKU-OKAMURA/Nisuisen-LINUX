#!/bin/bash
cd /
for i in `find . -type f`;do
A=`file $i |grep archive`
[[ ! -z $A ]] && strip -S $1
B=`file $i|grep "not stripped"`
if [[ ! -z $B ]] ;then
C=`echo $i |grep lib`

if [[ ! -z $C ]] ;then
strip -S $i
else
strip $i
fi
fi
done
