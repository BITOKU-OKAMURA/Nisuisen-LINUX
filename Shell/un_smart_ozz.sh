#!/bin/bash
export PATH=/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/X11/bin:/root/.composer/vendor/bin
cd /home/sdl/devel/Kyoutei2018 && /bin/nice -n -19 echo ""|php -a ./Controller.php "NaMaOzzuGet" 
exit

