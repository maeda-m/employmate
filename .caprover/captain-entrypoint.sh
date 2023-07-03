#!/bin/bash

# See: https://docs.docker.com/samples/rails/
mkdir -p /opt/rails/tmp/pids
rm -f /opt/rails/tmp/pids/server.pid

bundle install
rails db:migrate db:seed
rails assets:precompile
rm -f /opt/rails/public/robots.txt

exec "$@"
