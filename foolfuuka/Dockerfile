FROM alpine:latest
ARG COMPOSER_AUTH={}
ADD https://api.github.com/repos/pleebe/FoolFuuka/git/refs/heads/master /version.json
RUN apk --update --no-cache --virtual foolbuild add php7-fpm php7-bcmath php7-json php7-opcache php7-curl php7-mbstring php7-gd php7-zip php7-xml php7-pdo_mysql git composer && \
    mkdir -p /var/www/foolfuuka && \
    wget https://github.com/pleebe/FoolFuuka/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /var/www/foolfuuka && \
    cd /var/www/foolfuuka && \
    composer dump-autoload --optimize && \
    yes y | composer install && \
    mkdir -p /var/www/foolfuuka/app/foolz/foolfuuka/plugins/foolz\
             /var/www/foolfuuka/public/foolframe/foolz            \
             /var/www/foolfuuka/public/foolfuuka/foolz             \
             /var/www/foolfuuka/app/foolz/foolframe/config          \
             /var/www/foolfuuka/app/foolz/foolfuuka/config           \
             /var/www/foolfuuka/app/foolz/foolframe/logs           && \
    cd /var/www/foolfuuka/app/foolz/foolfuuka/plugins/foolz         && \
    git clone https://github.com/pleebe/foolfuuka-plugin-table.git   && \
    git clone https://github.com/pleebe/foolfuuka-plugin-adverts.git  && \
    git clone https://github.com/pleebe/foolfuuka-plugin-fortune.git   && \
    git clone https://github.com/FoolCode/foolfuuka-plugin-quests.git   && \
    git clone https://github.com/pleebe/foolfuuka-plugin-spam-guard.git  && \
    git clone https://github.com/FoolCode/foolfuuka-plugin-dice-roll.git  && \
    git clone https://github.com/pleebe/foolfuuka-plugin-intel-share.git   && \
    git clone https://github.com/pleebe/foolfuuka-plugin-popup-report.git   && \
    git clone https://github.com/pleebe/foolfuuka-plugin-thread-chunk.git    && \
    git clone https://github.com/pleebe/foolfuuka-plugin-external-links.git   && \
    git clone https://github.com/pleebe/foolfuuka-plugin-board-statistics.git  && \
    git clone https://github.com/pleebe/foolfuuka-plugin-cloudflare-cache-purge.git && \
    sed -i 's/timestamp/timestamped/g' /var/www/foolfuuka/src/Model/Search.php && \
    apk del foolbuild
COPY docker_DatabaseSetup.php /var/www/foolfuuka/vendor/foolz/foolframe/assets/themes-admin/foolz/foolframe-theme-admin/src/Partial/Install/DatabaseSetup.php
COPY foolframe_package.php /var/www/foolfuuka/app/foolz/foolframe/config/package.php
COPY foolfuuka_package.php /var/www/foolfuuka/app/foolz/foolfuuka/config/package.php
COPY SphinxDistConfig.php SphinxConfig.php /var/www/foolfuuka/assets/themes-admin/foolz/foolfuuka-theme-admin/src/Partial/Boards/

FROM alpine:latest
RUN adduser -D -g 'www' www
COPY --from=0 --chown=www:www /var/www/foolfuuka /var/www/foolfuuka
VOLUME [ "/var/www/foolfuuka/app/foolz/foolfuuka/config", \
         "/var/www/foolfuuka/app/foolz/foolframe/config", \
         "/var/www/foolfuuka/app/foolz/foolframe/logs", \
         "/var/www/foolfuuka/public/foolframe/foolz", \
         "/var/www/foolfuuka/public/foolfuuka/foolz" ]
