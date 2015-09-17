#!/bin/bash
set -e
asia-insight run rake db:migrate
touch tmp/restart.txt
exit 0
