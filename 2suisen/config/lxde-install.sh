#!/bin/bash
lxdebuiled(){
    foruda=$(tar tpvf $1|awk {'print $6'}|head -1)
    tar xpvf $1 && cd $foruda
    export XDG_DATA_DIRS=/usr/share
    eval "$configure_opt LDFLAGS="-L/usr/X11/lib" CFLAGS="-I/usr/X11/include" ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var"
    make && make install || return $?
    ldconfig
    cd .. && /bin/rm -Rf $foruda
    return $?
}
for LINE_ARGS in $(cat /usr/src/LXDE/list.txt);do
    lxdebuiled $LINE_ARGS || exit $?
done
exit 0
