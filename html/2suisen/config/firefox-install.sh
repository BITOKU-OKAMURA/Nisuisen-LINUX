cat >.mozconfig <<EOF
. /usr/src/mozilla-1.9.2/browser/config/mozconfig
#mk_add_options MOZ_OBJDIR=/home/admin/mozilla_firefox
ac_add_options --prefix=/usr
ac_add_options --enable-optimize
ac_add_options --disable-debug
ac_add_options --disable-shared
#ac_add_options --enable-static
#ac_add_options --disable-tests
ac_add_options  --disable-necko-wifi
ad_add_options --enable-default-toolkit=cairo-xlib
mk_add_options MOZ_CO_PROJECT=browser
EOF
make -f client.mk build
make install
