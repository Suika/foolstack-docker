# FoolFuuka(PHP) on Docker

The php processor of FoolStack. Useless without DB and NGINX, so check the compose file in the main directory.

Volume:
 - config: persistent configs
 - foolframe: Needed for NGINX container, due to some files being generated on the fly

```
version: '2'
services:
  foolstack-php:
    image: legsplits/foolstack:php
    container_name: foolstack-php
    restart: always
    volumes:
      - foolframe-temp:/var/www/foolfuuka/public/foolframe
      - foolframe-conf:/var/www/foolfuuka/app/foolz/foolframe/config
```
