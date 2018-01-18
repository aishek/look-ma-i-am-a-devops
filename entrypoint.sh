#!/bin/bash

cd /app

bin/rails db:environment:set RAILS_ENV=${RAILS_ENV} || true

bundle exec rake db:migrate

exec "$@"
