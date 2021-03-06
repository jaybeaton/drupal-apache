# Apache HTTP Server Docker Container Image for Drupal

[![Build Status](https://travis-ci.org/wodby/drupal-apache.svg?branch=master)](https://travis-ci.org/wodby/drupal-apache)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/drupal-apache.svg)](https://hub.docker.com/r/wodby/drupal-apache)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/drupal-apache.svg)](https://hub.docker.com/r/wodby/drupal-apache)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

Images are built via [Travis CI](https://travis-ci.org/wodby/drupal-apache) and published on [Docker Hub](https://hub.docker.com/r/wodby/drupal-apache). 

## Versions

| Apache | Alpine Linux |
| ------ | ------------ |  
| [2.4.26](https://github.com/wodby/drupal-apache/tree/master/2.4/Dockerfile) | 3.6 |  

## Environment Variables

See at [wodby/apache](https://github.com/wodby/apache)

| Variable | Default Value | Description |
| -------- | ------------- | ----------- |
| APACHE_BACKEND_HOST            |               |  |
| APACHE_BACKEND_PORT            | 9000          |  |
| APACHE_DRUPAL_HIDE_HEADERS     |               |  |
| APACHE_FCGI_PROXY_CONN_TIMEOUT | 5             |  |
| APACHE_FCGI_PROXY_TIMEOUT      | 60            |  |
| APACHE_SERVER_NAME             | drupal        |  |
| APACHE_SERVER_ROOT             | /var/www/html |  |
| APACHE_PRODUCTION_URL          |               | For image redirects to production |

## Complete Drupal stack

See [Docker4Drupal](https://github.com/wodby/docker4drupal) to get full docker-based stack for Drupal.
