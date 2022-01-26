#!/bin/bash

. ~/.bash_profile

rm -f /home/sdl/devel/Dairiten/Backup/*

pg_dump kplatform -U postgres > /home/sdl/devel/K-PlatForm/webroot/kplatform.dump

#pg_dump dairiten -U postgres > /home/sdl/devel/Dairiten/webroot/dairiten.dump

cd /home/sdl

#tar czpvf /home/sdl/tmp/backup_$(date +%Y%m%d)_.tar.gz  ./0/manage-dev.sidebizz.net ./devel/sidebizz ./devel/SideBizzManage

tar czpvf /home/sdl/tmp/k-pra_backup_$(date +%Y%m%d).tar.gz ./0/k-pra.web-x.co.jp ./devel/K-PlatForm/Define  ./devel/K-PlatForm/BissinesLogic ./devel/K-PlatForm/Action ./devel/K-PlatForm/templates ./devel/K-PlatForm/Common ./devel/K-PlatForm/Config ./devel/K-PlatForm/DB  ./devel/K-PlatForm/webroot/kplatform.dump 

scp -i ~/.ssh/webx_stg_key_pear.pem /home/sdl/tmp/*.gz ubuntu@stg.web-x.co.jp:~/AKIHATSUKI/
