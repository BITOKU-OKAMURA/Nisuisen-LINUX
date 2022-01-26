mkdir -p /mnt
mkdir -p /mnt/lfs/boot
mkdir -pv /mnt/lfs/{bin,command,etc,mnt,proc,sbin,service,sys,usr,dev,lib64,root,tmp,var}
cd /mnt/lfs && ln -sf ./lib64 ./lib
mkdir -pv /mnt/lfs/usr/lib64
cd /mnt/lfs/usr && ln -sf ./lib64 ./lib
mkdir -pv /mnt/lfs/usr/include
mkdir -pv /mnt/lfs/usr/lib64/pkgconfig
mkdir -pv /mnt/lfs/var/seg4
mkdir -pv /mnt/lfs/var/home
mkdir -pv /mnt/lfs/var/src
mkdir -pv /mnt/lfs/etc/sysconfig
mkdir -pv /mnt/lfs/usr/{bin,include,sbin}
mkdir -pv /mnt/lfs/usr/share/{doc,info,locale,man}
mkdir -pv /mnt/lfs/usr/share/{misc,terminfo,zoneinfo}
mkdir -pv /mnt/lfs/usr/share/man/man{1..8}
mkdir -pv /mnt/lfs/var/{lock,log,mail,run,spool}
mkdir -pv /mnt/lfs/var/{cache,lib/{misc,locate}}
mkdir -pv /mnt/lfs/usr/X11
chmod 755 /mnt/lfs/usr/X11
cd /mnt/lfs && ln -sf ./var/seg4 ./
cd /mnt/lfs && ln -sf ./var/home ./
cd /mnt/lfs/usr && ln -sf ../var/src ./
cd /mnt/lfs/usr && ln -sf ../usr ./local
cd /mnt/lfs && ln -sf ./var ./opt
cd /mnt/lfs/var && ln -sf ../tmp ./
cd /mnt/lfs/usr && ln -sf ../tmp ./
cd /mnt/lfs/var/seg4 && ln -sf ../src ./
chmod 1777 /mnt/lfs/tmp
