#!/bin/sh

set -x -e

echo "Pushing to heroku acceptance environment"
git push git@heroku.com:json-rails-acceptance.git master

echo "Migrating acceptance database"
heroku run rake db:migrate --app json-rails-acceptance

echo "Restarting app"
heroku restart --app json-rails-acceptance
