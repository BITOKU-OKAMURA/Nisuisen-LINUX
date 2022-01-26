#!/bin/bash
export PATH="/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/X11/bin:/root/.composer/vendor/bin"
cd /home/sdl/devel/Dairiten || exit 9
mkdir -p ./Backup
find ./* -type f -name "*.*"|grep -Ev "^./vendor"|grep -Ev "^./ODMS"|grep -Ev "^./Log"|grep -Ev "^./Backup"|xargs tar rpvf ./Backup/dairiten.$(date +%Y%m%d%H).tar
find /home/sdl/dairiten.gateweb.me.uk/* -type f |xargs tar rpvf ./Backup/dairiten.$(date +%Y%m%d%H).tar

