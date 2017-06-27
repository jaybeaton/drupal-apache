<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    ServerName {{ getenv "APACHE_SERVER_NAME" "drupal" }}
    DirectoryIndex /index.php index.php

    <Directory "/var/www/html">
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
</VirtualHost>
