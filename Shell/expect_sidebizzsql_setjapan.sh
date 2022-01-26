#!/bin/sh
export PATH=/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/X11/bin:/root/.composer/vendor/bin
scp -i ~/.ssh/webx_aws_prod_key.pem ubuntu@www.web-x.co.jp:/home/ubuntu/backup/sidebizz_$(date +%Y%m%d).dump /home/sdl/tmp/

test -f /home/sdl/tmp/sidebizz_$(date +%Y%m%d).dump || exit 9 

PW="postgres"
expect -c "
set timeout 5
spawn su - postgres -c \"dropdb sidebizz && createdb sidebizz && psql sidebizz < /home/sdl/tmp/sidebizz_$(date +%Y%m%d).dump  && psql\"
expect \":\"
send \"${PW}\n\"
expect \"$\"
send \"ALTER DATABASE sidebizz SET timezone TO 'Asia/Tokyo';\n\"
expect \"#\"
send \"ALTER DATABASE sidebizz OWNER TO sidebizz;\n\"
expect \"#\"
send \"exit\n\"
expect \"$\"
send \"exit\n\"
exit 0
"

/ulib/joblib/webx_CmdScoutSearch.sh

scp -i ~/.ssh/webx_aws_prod_key.pem /home/sdl/tmp/nichji_$(date +%Y%m%d).tar.gz ubuntu@www.web-x.co.jp:/home/ubuntu/work/

exit

