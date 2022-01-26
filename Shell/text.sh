#!/bin/sh
NPW=nishi8888

expect -c "
spawn su - sdl -c \"/ulib/joblib/webx_CmdScoutSearch.sh\"
expect \":\"
send \"${NPW}\n\"
expect \"$\"
send \"exit\n\"
"
exit;


