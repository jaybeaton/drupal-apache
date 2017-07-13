FROM wodby/apache:2.4-1.0.1

ENV WODBY_DIR_FILES /mnt/files

RUN rm /etc/gotpl/vhost.conf.tpl && \
    mkdir -p $WODBY_DIR_FILES

COPY drupal.conf.tpl /etc/gotpl/
COPY init/* /docker-entrypoint-init.d/