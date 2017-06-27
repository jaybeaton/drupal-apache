#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

apacheExec() {
    docker-compose -f test/docker-compose.yml exec --user=82 apache "${@}"
}

docker-compose -f test/docker-compose.yml up -d

apacheExec make check-ready -f /usr/local/bin/actions.mk

echo "Checking Drupal endpoints"
echo -n "Checking / page... "
apacheExec curl -I "localhost" | grep '302 Found'
echo -n "authorize.php...   "
apacheExec curl -I "localhost/core/authorize.php" | grep '500 Service unavailable'
echo -n "install.php...     "
apacheExec curl -I "localhost/core/install.php" | grep '200 OK'
echo -n "statistics.php...  "
apacheExec curl -I "localhost/core/modules/statistics/statistics.php" | grep '500 Service unavailable'
echo -n "cron...            "
apacheExec curl -I "localhost/cron" | grep '302 Found'
echo -n "index.php...       "
apacheExec curl -I "localhost/index.php" | grep '302 Found'
echo -n "update.php...      "
apacheExec curl -I "localhost/update.php" | grep '500 Service unavailable'
echo -n ".htaccess...       "
apacheExec curl -I "localhost/.htaccess" | grep '403 Forbidden'
echo -n "robots.txt...      "
apacheExec curl -I "localhost/robots.txt" | grep '200 OK'
echo -n "drupal.js...       "
apacheExec curl -I "localhost/core/misc/drupal.js" | grep '200 OK'
echo -n "druplicon.png...   "
apacheExec curl -I "localhost/core/misc/druplicon.png" | grep '200 OK'

echo -n "Checking non existing php endpoint... "
apacheExec curl -I "localhost/non-existing.php" | grep '302 Found'

docker-compose -f test/docker-compose.yml down