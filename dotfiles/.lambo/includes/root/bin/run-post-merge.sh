#!/bin/bash

./bin/run-on-matched-files.sh yarn.lock 'yarn'
./bin/run-on-matched-files.sh composer.lock 'composer install'
./bin/run-on-matched-files.sh database/migrations 'php artisan app:reset'
./bin/run-on-matched-files.sh resources/js 'yarn run dev'
./bin/run-on-matched-files.sh resources/sass 'yarn run dev'
exit 0
