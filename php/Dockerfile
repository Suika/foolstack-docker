FROM suika/foolstack:base
ENTRYPOINT [ "sh", "/entrypoint.sh" ]
CMD ["php-fpm7", "--nodaemonize", "--force-stderr"]
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD sh /php-fpm-healthcheck -v || exit 1
RUN apk --update --no-cache add php7-fpm php7-bcmath php7-json php7-opcache php7-curl php7-mbstring php7-gd php7-zip php7-pdo_pgsql php7-pgsql \
    php7-xml php7-pdo_mysql php7-mysqli php7-fileinfo php7-exif php7-iconv php7-pecl-apcu php7-session fcgi imagemagick libintl gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del gettext && \
    apk add gnu-libiconv --update --update-cache --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini
COPY entrypoint.sh .foolframe.cache.php.env .foolframe.db.php.env .foolframe.config.php.env .foolfuuka.config.php.env php-fpm-healthcheck /
ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so \
    FPM_PM=dynamic \
    FPM_PM_MAX_CHILDREN=5 \
    FPM_PM_START_SERVICE=2 \
    FPM_PM_MIN_SPARE_SERVERS=1 \
    FPM_PM_MAX_SPARE_SERVERS=3 \
    REDIS_TYPE=redis \
    REDIS_PREFIX=foolframe_OwO_ \
    REDIS_SERVERS="'foolstack-redis:6379'" \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    DB_DRIVER=pdo_mysql \
    DB_HOST=foolstack-db \
    DB_PORT=3306 \
    DB_NAME=foolfuuka \
    DB_USER=foolfuuka \
    DB_PASS=pass \
    DB_CHARSET=utf8mb4 \
    DB_PREFIX=ff_ \
    COOKIE_PREFIX=foolframe_ugay_
