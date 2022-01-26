#!/bin/bash
. /root/.bash_profile
s3fs nicebort.jlc.link /home/sdl/devel/Kyoutei2018/webroot -o allow_other,use_cache=/tmp,uid=2,gid=16,passwd_file=/etc/passwd-s3fs

