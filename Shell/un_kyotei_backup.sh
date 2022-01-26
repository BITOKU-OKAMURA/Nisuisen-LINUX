#!/bin/bash

. ~/.bash_profile


pg_dump kyoutei -U postgres > /home/sdl/devel/Kyoutei2018/webroot/kyoutei.dump


cd /home/sdl



tar czpvf /home/sdl/tmp/kyoutei_backup_$(date +%Y%m%d)_.tar.gz ./devel/Kyoutei2018/Define  ./devel/Kyoutei2018/BissinesLogic ./devel/Kyoutei2018/Action ./devel/Kyoutei2018/templates ./devel/Kyoutei2018/Common ./devel/Kyoutei2018/Config ./devel/Kyoutei2018/DB ./devel/Kyoutei2018/Test ./devel/Kyoutei2018/webroot/kyoutei.dump ./devel/Kyoutei2018/local_public 

