#!/bin/sh
echo "gcc -Os -m64 -mtune=nocona -march=nocona -ltinfo " > ./conf-cc && \
sed -e 's/extern int errno;/#include <errno.h>/g' -i ./error.h
exit $?
