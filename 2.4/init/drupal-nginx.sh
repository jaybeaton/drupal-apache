#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

chown www-data:www-data "${WODBY_DIR_FILES}"

gotpl /etc/gotpl/drupal.conf.tpl > "${APACHE_DIR}/conf/conf.d/drupal.conf"
