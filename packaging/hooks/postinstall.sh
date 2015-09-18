#!/bin/bash
set -e
echo 'Asia Insight installed!'
echo 'Migrating the database...'
asia-insight run rake db:migrate
echo 'Database successfully migrated!'
touch tmp/restart.txt
exit 0