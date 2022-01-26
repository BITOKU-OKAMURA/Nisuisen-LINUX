#!/bin/bash
cd /tmp
grub-mkdevicemap --device-map=device.map
export HDD=`cat device.map|grep $(grep -v rootfs /proc/mounts |grep boot|awk {'print $1'}|sed 's/[0-9]//g')`
export BOOT="/dev/$(echo $HDD|awk {'print $2'}|cut -d"/" -f3 |cut -b1,2)a"
rm -f ./device.map
grub-install --grub-setup=/bin/true $(echo $HDD |awk {'print $2'})
grub-mkconfig -o /boot/grub/grub.cfg
eval "sed -i 's@(hd1,1)@(hd0,1)@g' /boot/grub/grub.cfg"
eval "sed -i 's@search@#search@g' /boot/grub/grub.cfg"
eval "sed -i 's@$(echo $HDD|awk {'print $2'})@$BOOT@g' /boot/grub/grub.cfg"
eval "grub-setup '$(echo $HDD|awk {'print $1'})'"
