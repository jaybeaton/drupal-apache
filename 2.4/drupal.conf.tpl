<VirtualHost *:80>
    DocumentRoot {{ getenv "APACHE_SERVER_ROOT" "/var/www/html" }}
    ServerName {{ getenv "APACHE_SERVER_NAME" "drupal" }}
    DirectoryIndex /index.php index.php

    <Directory {{ getenv "APACHE_SERVER_ROOT" "/var/www/html" }}>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
    </Directory>

    <Proxy "fcgi://{{ getenv "APACHE_BACKEND_HOST" }}:{{ getenv "APACHE_BACKEND_PORT" "9000" }}/">
        ProxySet connectiontimeout={{ getenv "APACHE_FCGI_PROXY_CONN_TIMEOUT" "5" }} timeout={{ getenv "APACHE_FCGI_PROXY_TIMEOUT" "60" }}
    </Proxy>
    <FilesMatch "\.php$">
        <If "-f %{REQUEST_FILENAME}">
            SetHandler "proxy:fcgi://{{ getenv "APACHE_BACKEND_HOST" }}:{{ getenv "APACHE_BACKEND_PORT" "9000" }}"
        </If>
    </FilesMatch>
{{ if getenv "APACHE_DRUPAL_HIDE_HEADERS" }}
    Header always unset X-Drupal-Dynamic-Cache
    Header always unset X-Drupal-Cache
    Header always unset X-Generator
{{ end }}

{{ if getenv "APACHE_PRODUCTION_URL" }}
    RewriteEngine on
    # Force image styles that have local files that exist to be generated.
    RewriteCond %{REQUEST_URI} ^/sites/([^\/]*)/files/styles/[^\/]*/public/((.*))$
    RewriteCond %{DOCUMENT_ROOT}/sites/%1/files/%2 -f
    RewriteRule ^(.*)$ $1 [QSA,L]
    # Otherwise, send anything else that's in the files directory to the
    # production server.
    RewriteCond %{REQUEST_URI} ^(/sites/)[^\/]*(/files/.*)$
    RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/css/.*$
    RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/js/.*$
    RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/advagg_css/.*$
    RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/advagg_js/.*$
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-f
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ {{ getenv "APACHE_PRODUCTION_URL" }}%1default%2 [QSA,L]
{{ end }}

    Include conf/healthz.conf
</VirtualHost>
