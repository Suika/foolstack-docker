# FoolFuuka(PHP) on Docker

The php processor of FoolStack. Useless without DB and NGINX, so check the compose file in the main directory.

Volume:
 - config: persistent configs
 - foolframe: Needed for NGINX container, due to some files being generated on the fly

```
version: '2'
services:
  foolstack-php:
    image: suika/foolstack:php
    container_name: foolstack-php
    restart: always
    environment:
      - REDIS_TYPE=dummy
    volumes:
      - foolframe-foolframe-temp:/var/www/foolfuuka/public/foolframe/foolz
      - foolframe-foolfuuka-temp:/var/www/foolfuuka/public/foolfuuka/foolz
      - foolframe-foolframe-conf:/var/www/foolfuuka/app/foolz/foolfuuka/config
      - foolframe-foolframe-conf:/var/www/foolfuuka/app/foolz/foolframe/config
      - foolframe-foolframe-logs:/var/www/foolfuuka/app/foolz/foolframe/logs
```

Environment:
```
FPM_PM=dynamic
FPM_PM_MAX_CHILDREN=5
FPM_PM_START_SERVICE=2
FPM_PM_MIN_SPARE_SERVERS=1
FPM_PM_MAX_SPARE_SERVERS=3

REDIS_TYPE=redis # set to dummy to not use redis
REDIS_PREFIX=foolframe_OwO_
REDIS_SERVERS='foolstack-redis:6379'

LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
```