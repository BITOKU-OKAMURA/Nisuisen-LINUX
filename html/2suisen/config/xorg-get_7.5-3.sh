#!/bin/bash
. ~/.2suisen/config/environment
protoinst(){
    while read LINE; do
        XORGINST ./$LINE
        ret=$?
        cd ../
        ldconfig
    done
    return $ret
}

libinst(){
    while read LINE; do
        case $LINE in
            libXfont-[0-9]* )
                 XORGINST ./$LINE --disable-devel-docs
                 ;;
            libX11-[0-9]* )
                 XORGINST ./$LINE --with-xcb
                 ;;
            libXt-[0-9]* )
                 XORGINST ./$LINE --with-appdefaultdir=/etc/X11/app-defaults
                 ;;
            * )
                 XORGINST ./$LINE
                 ;;
        esac
        ret=$?
        cd ../
    ldconfig
    done
    return $ret
}

appinst(){
    while read LINE; do
        case $LINE in
        twm-[0-9]* )
               tarcd "./$LINE"
               sed -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' -i src/Makefile.in
               eval "$configure_opt ./configure --prefix=/usr/X11"
               make
               make install
               ;;
        xinit-[0-9]* )
               XORGINST ./$LINE --with-xinitdir=/etc/X11/app-defaults
               ;;
           * )
               XORGINST ./$LINE
               ;;
        esac
        ret=$?
        cd ../
    ldconfig
    done
    return $ret
}

driverinst(){
    while read LINE; do
        tarcd "./$LINE"

case $LINE in
xf86-input-evdev-[0-9]* | xf86-video-ati-[0-9]* | \
xf86-video-fbdev-[0-9]* | xf86-video-glint-[0-9]* | \
xf86-video-newport-[0-9]* )
    sed -i -e "s/\xc3\xb8/\\\\[\/o]/" \
           -e "s/\xc3\xa4/\\\\[:a]/" \
           -e "s/\xc3\x9c/\\\\[:U]/" man/*.man
    ;;
esac &&
case $LINE in
xf86-video-s3-[0-9]* | xf86-video-xgi-[0-9]* )
    for file in `grep -Rl "xf86Version.h" *`
    do
        sed 's@xf86Version.h@xorgVersion.h@g' -i "$file"
    done
    ;;
esac &&

        XORGINST ./$LINE --with-xorg-module-dir=$XORG_PREFIX/lib/X11/modules
        ret=$?
        cd ../
    ldconfig
    done
    return $ret
}


cd /usr/src

test $1 == "driver" && sed -i 's/#xf86/xf86/g' ./driver-7.5-3.wget

mkdir -p $1 && cd $1
grep -v '^#' ../$1-7.5-3.wget |wget -i- -c -B http://xorg.freedesktop.org/releases/individual/$1/ && md5sum -c ../$1-7.5-3.md5
case "$1" in
    proto|util|font)
        cat ../$1-7.5-3.wget|grep -v "#"|grep tar|protoinst || exit 9
    ;;
    lib)
        cat ../lib-7.5-3.wget|grep -v "#"|grep tar|libinst || exit 9
    ;;
    app)
        cat ../app-7.5-3.wget|grep -v "#"|grep tar|appinst || exit 9
    ;;
    driver)
        cat ../driver-7.5-3.wget|grep -v "#"|grep tar|driverinst || exit 9
    ;;
    *)
esac
cd ../
rm -Rf ./$1
