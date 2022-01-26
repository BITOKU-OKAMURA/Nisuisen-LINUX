#!/bin/sh
[ -f ../2suisen/extra/$1 ] || exit 9

cp -p ../Configure/2nd/sed-4.2.2.2suisen ../Configure/2nd/$1
cat ../2suisen/extra/$1

