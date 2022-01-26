#!/bin/sh
cd $LFS/usr/lib && tar cpvf ../src/libgomp.tar ./libgomp*
/bin/rm -f ./libgomp*
cd ../../lib && tar xpvf ../usr/src/libgomp.tar
cd $LFS/lib && ln -sfv ./libgmp.so.10.0.1 ./libgmp.so.3
cd $LFS/lib && ln -sfv ./libmpfr.so.4.0.0 ./libmpfr.so.1
cd $LFS/lib && ln -sfv ../usr/lib/libncurses.so.5 ./
cd $LFS/usr && /bin/rm -Rf ./var && ln -sfv ../var ./
cd $LFS/usr/bin && ln -sv ../../bin/install ./

/bin/rm -Rf $LFS/usr/src/2suisen
mkdir -p $LFS/usr/src/2suisen
echo "" > $JOBDIR/install_log
touch $JOBDIR/.compile_option
/bin/cp -pvf $JOBDIR/config/ORIKAESHI.list $JOBDIR/config/SAGYOU.list
/bin/cp -pvRf $JOBDIR/* $LFS/usr/src/2suisen/
/bin/cp -pvRf $JOBDIR/.compile_option $LFS/usr/src/2suisen/
/bin/cp -pf $JOBDIR/config/environment.orikaeshisaki $LFS/usr/src/2suisen/config/environment
/bin/cp -pf $JOBDIR/config/environment.temae $JOBDIR/config/environment

mkdir -p $LFS/usr/X11
chmod 755 $LFS/usr/X11
mkdir -p $LFS/usr/X11/include/X11
cd $LFS/usr/include && ln -sfv ../X11/include/X11 ./
cd $LFS/usr && ln -sfv ./X11 ./X11R6

cd $LFS/usr/bin && ln -sv ../../bin/env ./

### node setting ###

#/etc/mtab
touch $LFS/etc/mtab


#/root/.bash_profile
cat > $LFS/root/.bash_profile << "EOF"
set +h
umask 022
export PATH=/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:./:~/bin
export LANG=C
export LC_ALL=C
PS1="[\u@\h] \W# "
EOF

#/etc/passwd
cat > $LFS/etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

#/etc/group
cat > $LFS/etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tty:x:4:
tape:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
mail:x:34:
nogroup:x:99:
EOF

#/etc/nsswitch.conf
cat > $LFS/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

#/etc/ld.so.conf

cat > $LFS/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf

/usr/local/lib
/usr/X11/lib

# End /etc/ld.so.conf
EOF

# /usr/bin/lex

cat > $LFS/usr/bin/.lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF
chmod -v 755 $LFS/usr/bin/lex

# /etc/syslog.conf 
cat > $LFS/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

# /etc/inittab
cat > $LFS/etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc sysinit

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

# /etc/vimrc
cat > $LFS/etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

# /etc/sysconfig/clock 
cat > $LFS/etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF

# /etc/sysconfig/console
cat > $LFS/etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

KEYMAP="jp106"

# End /etc/sysconfig/console
EOF

# /etc/inputrc
cat > $LFS/etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

# /etc/profile
cat > $LFS/etc/profile << "EOF"
# Begin /etc/profile

export LANG=C

# End /etc/profile
EOF

echo "HOSTNAME=localhost.localdomain" > $LFS/etc/sysconfig/network

# /etc/hosts
cat > $LFS/etc/hosts << "EOF"
# Begin /etc/hosts (no network card version)

127.0.0.1 <HOSTNAME.example.org> <HOSTNAME> localhost

# End /etc/hosts (no network card version)
EOF

#/etc/fstab
cat > $LFS/etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type   options         dump  fsck
#                                                        order
### HDD1 ###    /boot        ext2    defaults,noatime     0 0
### HDD3 ###    /            ext4  defaults        0 0
### HDD2 ###      swap         swap   pri=1           0     0
proc           /proc        proc   defaults        0     0
sysfs          /sys         sysfs  defaults        0     0
devpts         /dev/pts     devpts gid=4,mode=620  0     0
tmpfs          /dev/shm     tmpfs  defaults        0     0
# End /etc/fstab
EOF


eval "sed -i 's@### HDD1 ###@$HDD$one@g' $LFS/etc/fstab"
eval "sed -i 's@### HDD2 ###@$HDD$two@g' $LFS/etc/fstab"
eval "sed -i 's@### HDD3 ###@$HDD$tree@g' $LFS/etc/fstab"

# modprobe.d
mkdir -pv $LFS/etc/modprobe.d
cat > $LFS/etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

# /etc/dbus-1/session-local.conf
mkdir -pv $LFS/etc/dbus-1/
cat > $LFS/etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

# /etc/pam.conf
mkdir -pv $LFS/etc/pam.d/
cat > $LFS/etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok

# End /etc/pam.d/other

# Begin /etc/pam.conf

#other           auth            required        pam_unix.so
#other           account         required        pam_unix.so
#other           session         required        pam_unix.so
#other           password        required        pam_unix.so

# End /etc/pam.conf
EOF


# /etc/X11/app-defaults/XTerm
mkdir -pv $LFS/etc/X11/app-defaults
cat > $LFS/etc/X11/app-defaults/XTerm << "EOF"
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
EOF
#/etc/X11/xorg.conf
cat > $LFS/etc/X11/xorg.conf << "EOF"
Section "ServerFlags"
        Option   "AutoAddDevices"    "False"
        Option   "AutoEnableDevices" "False"
        Option   "AllowEmptyInput"   "False"
EndSection

Section "Module"
        #Load "bitmap"
        #Load "ddc"
        #Load "dri"
        #Load "extmod"
        Load "freetype"
        #Load "glx"
        #Load "int10"
        #Load "vbe"
EndSection

Section "InputDevice"
        Identifier  "Keyboard1"
        Driver      "kbd"
        Option "XkbRules"   "xorg"
        Option "XkbModel"   "jp106"
        Option "XkbLayout"  "jp"
        Option "AutoRepeat" "500 5"
        Option "LeftAlt"    "Meta"
        Option "RightAlt"   "Meta"
        Option "XkbOptions" "terminate:ctrl_alt_bksp,"
EndSection

EOF


### chroot priset ###

mkdir -p $LFS/var/run/
touch $LFS/var/run/utmp 
touch $LFS/var/log/btmp
touch $LFS/var/log/lastlog
touch $LFS/var/log/wtmp
chgrp -v utmp $LFS/var/run/utmp $LFS/var/log/lastlog
chmod -v 664 $LFS/var/run/utmp $LFS/var/log/lastlog
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3
mount -v --bind /dev $LFS/dev
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys


