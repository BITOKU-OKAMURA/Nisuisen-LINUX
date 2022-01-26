#?bin/sh
export PATH=/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/sbin:/bin:/usr/X11/bin:/root/.composer/vendor/bin
cd /home/sdl/devel/SideBizzManage || exit 9
echo ""|php -a ./Controller.php "CmdScoutSearch" || exit 9
cd /home/sdl/tmp || exit 9
pg_dump -U postgres --clean --table sonsigner_scout_lenges sidebizz > ./sonsigner_scout_lenges.sql
pg_dump -U postgres --clean --table scout_search_data sidebizz > ./scout_search_data.sql
tar czpvf ./nichji_$(date +%Y%m%d).tar.gz ./*.sql 

exit $?








