#!/bin/sh

if [ ! -f "/var/www/foolfuuka/app/foolz/foolfuuka/config/config.php" ]; then
    echo "$FILE exist"
    export SECURE_TRIPCODE_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 500 | base64 | sed "s/^/'/g;s/$/'\./g;$ s/.$//")
    envsubst < /.config.php.env > /var/www/foolfuuka/app/foolz/foolfuuka/config/config.php
fi

if [ "$REDIS_TYPE" != "redis" ] ; then
    unset REDIS_SERVERS
    export REDIS_TYPE=dummy
fi

envsubst < /.cache.php.env > /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
chown www:www /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
chown www:www /var/www/foolfuuka/app/foolz/foolfuuka/config/config.php

"$@"
