# FoolStack

```
version: '2'
services:
  foolstack-db:
    image: percona:5.7
    container_name: foolstack-db
    volumes:
      - foolframe-db:/var/lib/mysql
    ports:
      - 1347:3306
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_USER: asagi
      MYSQL_PASSWORD: asagipassword
  foolstack-php:
    image: legsplits/foolstack:php
    container_name: foolstack-php
    depends_on:
      - foolstack-db
    volumes:
      - foolframe:/var/www/foolfuuka/public/foolframe
      - foolframe-conf:/var/www/foolfuuka/app/foolz/foolframe/config/
    restart: always
  foolstack-nginx:
    image: legsplits/foolstack:nginx
    container_name: foolstack-nginx
    restart: always
    depends_on:
      - foolstack-db
      - foolstack-php
    volumes:
      - foolframe:/var/www/foolfuuka/public/foolframe:ro
      - foolframe-boards:/var/www/foolfuuka/public/foolfuuka/boards:ro
    ports:
      - 1346:80
  foolstack-asagi:
    image: legsplits/foolstack:asagi
    container_name: foolstack-asagi
    depends_on:
      - foolstack-db
    environment:
      - UID=1000
      - GID=1000
      - ASAGI_DB_HOST=some.other.host
    volumes:
      - foolframe-boards:/boards  # storage where images and thumbs will be written to
  foolstack-sphinx:
    image: macbre/sphinxsearch:latest
    container_name: foolstack-sphinx
    depends_on:
      - foolstack-db
    volumes:
    - foolframe-sphinx:/opt/sphinx/index  # directory where sphinx will store index data
#    - ./sphinx.conf:/opt/sphinx/conf/sphinx.conf  # SphinxSE configuration file
    mem_limit: 512m # match indexer.value from sphinx.conf
volumes:
  foolframe:
    driver: local
  foolframe-conf:
    driver: local
  foolframe-db:
    driver: local
  foolframe-sphinx:
    driver: local
  foolframe-boards:
    driver: local
```