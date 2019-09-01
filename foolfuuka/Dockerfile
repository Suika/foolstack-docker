FROM alpine:latest
ARG COMPOSER_AUTH={}
RUN adduser -D -g 'www' www
RUN apk --update --no-cache --virtual foolbuild add php7-fpm php7-bcmath php7-json php7-opcache php7-curl php7-mbstring php7-gd php7-zip php7-xml php7-pdo_mysql git composer && \
    mkdir -p /var/www/foolfuuka && \
    wget https://github.com/pleebe/FoolFuuka/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /var/www/foolfuuka && \
    cd /var/www/foolfuuka && \
    composer dump-autoload --optimize && \
    yes y | composer install && \
    mkdir -p /var/www/foolfuuka/app/foolz/foolfuuka/plugins/foolz && \
    cd /var/www/foolfuuka/app/foolz/foolfuuka/plugins/foolz && \
    git clone https://github.com/pleebe/foolfuuka-plugin-board-statistics.git && \
    git clone https://github.com/FoolCode/foolfuuka-plugin-dice-roll.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-intel-share.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-popup-report.git && \
    git clone https://github.com/FoolCode/foolfuuka-plugin-quests.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-spam-guard.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-thread-chunk.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-adverts.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-external-links.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-fortune.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-cloudflare-cache-purge.git && \
    git clone https://github.com/pleebe/foolfuuka-plugin-table.git && \
    apk del foolbuild && \
    chown -R www:www /var/www/foolfuuka

