#!/bin/bash
export RAILS_ROOT=/home/sdl/public_html/redmine-3.1.7
cd $RAILS_ROOT && bundle exec unicorn_rails -c config/unicorn.rb -E production -D  > /dev/null 2>&1 
exit $?
