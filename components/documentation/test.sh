#!/bin/bash

exit_code=0

echo "*** Running documentation engine specs"
bundle install | grep Installing
RAILS_ENV=test bundle exec rake db:create
RAILS_ENV=test bundle exec rake db:migrate
bundle exec rspec spec
exit_code+=$?

exit $exit_code
