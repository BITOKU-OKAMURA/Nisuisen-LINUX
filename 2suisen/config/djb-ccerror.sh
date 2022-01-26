#!/bin/sh
echo "gcc -O3 -march=\"native\"" > ./conf-cc
sed -e 's/extern int errno;/#include <errno.h>/g' -i ./error.h
