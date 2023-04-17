#!/bin/bash

# See: https://docs.docker.com/samples/rails/
mkdir -p /opt/rails/tmp/pids
rm -f /opt/rails/tmp/pids/server.pid

if [ -e /opt/rails/bin/rails ]; then
  bundle install
  rails db:migrate
fi

exec "$@"
