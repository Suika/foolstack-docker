#!/bin/sh

if [ "$REDIS_ENABLE" = true ] && [ ! -z $REDIS_SERVERS ]; then
    envsubst < /.cache.php.env > /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
    chown www:www /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
else
    cat /.cache.php.default > /var/www/foolfuuka/app/foolz/foolframe/config/cache.php
fi

"$@"
