#!/bin/sh

if [ ! -f "/var/www/foolfuuka/app/foolz/foolfuuka/config/config.php" ]; then
    echo "$FILE exist"
    export SECURE_TRIPCODE_SALT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 500 | base64 | sed "s/^/'/g;s/$/'\./g;$ s/.$//")
    envsubst < /.foolfuuka.config.php.env > /var/www/foolfuuka/app/foolz/foolfuuka/config/config.php
fi

if [ "$REDIS_TYPE" != "redis" ] ; then
    unset REDIS_SERVERS
    export REDIS_TYPE=dummy
fi

envsubst < /.foolframe.cache.php.env > /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
envsubst < /.foolframe.db.php.env > /var/www/foolfuuka/app/foolz/foolframe/config/db.php
envsubst < /.foolframe.config.php.env > /var/www/foolfuuka/app/foolz/foolframe/config/config.php

chown www:www -R /var/www/foolfuuka/app/foolz/foolframe/config
chown www:www -R /var/www/foolfuuka/app/foolz/foolfuuka/config

"$@"
