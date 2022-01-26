cd /mnt/lfs
for line_args in $(find /home/okamura/RedHat64_GateWeb/RPMS/*.rpm) ;do
rpm2cpio $line_args | cpio -id
#echo $line_args
done
