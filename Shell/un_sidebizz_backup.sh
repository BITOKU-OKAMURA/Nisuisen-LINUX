#!/bin/bash

. ~/.bash_profile

rm -f /home/sdl/devel/Dairiten/Backup/*

pg_dump sidebizz -U postgres > /home/sdl/devel/SideBizzManage/webroot/sidebizz.dump

#pg_dump dairiten -U postgres > /home/sdl/devel/Dairiten/webroot/dairiten.dump

cd /home/sdl

#tar czpvf /home/sdl/tmp/backup_$(date +%Y%m%d)_.tar.gz  ./0/manage-dev.sidebizz.net ./devel/sidebizz ./devel/SideBizzManage


tar czpvf /home/sdl/tmp/sidebizz_backup_$(date +%Y%m%d)_.tar.gz ./0/manage-dev.sidebizz.net ./devel/sidebizz/app/Http/Controllers ./devel/sidebizz/resources/views ./devel/sidebizz/public/planet ./devel/sidebizz/public/slide ./devel/sidebizz/routes ./devel/SideBizzManage/Define  ./devel/SideBizzManage/BissinesLogic ./devel/SideBizzManage/Action ./devel/SideBizzManage/templates ./devel/SideBizzManage/Common ./devel/SideBizzManage/Config ./devel/SideBizzManage/DB ./devel/SideBizzManage/Test ./devel/SideBizzManage/webroot/sidebizz.dump ./devel/SideBizzManage/Util/Nginx/jni_manage-dev.sidebizz.net 

scp -i ~/.ssh/webx_stg_key_pear.pem /home/sdl/tmp/*.gz ubuntu@stg.web-x.co.jp:~/AKIHATSUKI/
