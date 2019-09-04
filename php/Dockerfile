FROM legsplits/foolstack:base
ENV FPM_PM=dynamic FPM_PM_MAX_CHILDREN=5 FPM_PM_START_SERVICE=2 FPM_PM_MIN_SPARE_SERVERS=1 FPM_PM_MAX_SPARE_SERVERS=3 REDIS_ENABLE=false
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["php-fpm7", "--nodaemonize", "--force-stderr"]
RUN apk --update --no-cache add php7-fpm php7-bcmath php7-json php7-opcache php7-curl php7-mbstring php7-gd php7-zip php7-xml php7-pdo_mysql php7-mysqli php7-fileinfo php7-exif fcgi imagemagick libintl gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del gettext
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini
COPY php-fpm-healthcheck /usr/bin
COPY entrypoint.sh .cache.php.env .cache.php.default /
VOLUME /var/www/foolfuuka/app/foolz/foolframe/config
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD php-fpm-healthcheck -v || exit 1
