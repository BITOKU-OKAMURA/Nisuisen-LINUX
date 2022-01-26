#!/bin/bash

. ~/.bash_profile
cd /home/sdl || exit 9
tar czpvf /home/sdl/tmp/ver2_sidebizz_$(date +%Y%m%d).tar.gz ./0/version2.sidebizz.net ./devel/V2_Sidebizz/Define  ./devel/V2_Sidebizz/BissinesLogic ./devel/V2_Sidebizz/Action ./devel/V2_Sidebizz/templates ./devel/V2_Sidebizz/Common ./devel/V2_Sidebizz/Config ./devel/V2_Sidebizz/DB ./devel/V2_Sidebizz/Util ./devel/sidebizz/public/wWZr22c5HUZuND7LnnhZVXtDq6

scp -i ~/.ssh/webx_stg_key_pear.pem /home/sdl/tmp/ver2_sidebizz_$(date +%Y%m%d).tar.gz ubuntu@stg.web-x.co.jp:~/AKIHATSUKI/
