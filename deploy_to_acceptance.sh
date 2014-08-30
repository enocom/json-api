#!/bin/env bash

set -x -e

echo "Pushing to heroku acceptance environment"
git push heroku master

echo "Migrating acceptance database"
heroku run rake db:migrate

echo "Restarting app"
heroku restart

echo "Tagging current commit as deployed to acceptance"
tag_name="acceptance-$(date +%s)"
git tag $tag_name
git push origin $tag_name
