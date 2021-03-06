#!/bin/bash

sed -i 's|host: .*|host: '"${DBHOST}"'|g' config/database.yml

# We assume single-user installation as 
# done in our rvm.sh script and 
# in Travis-CI
source $HOME/.rvm/scripts/rvm

rm -f Gemfile
cp Gemfile-ruby Gemfile
cp Gemfile-ruby.lock Gemfile.lock

$NGINX_HOME/sbin/nginx -c $TROOT/config/nginx.conf

rvm ruby-2.0.0-p0 do bundle exec unicorn_rails -E production -c $TROOT/config/unicorn.rb &