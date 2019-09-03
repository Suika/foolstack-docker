# FoolStack

A full FoolFuuka stack on top of docker to remove the setup overhead and allow portability.

```
version: '2'
services:
  foolstack-db:
    image: percona:5.7
    container_name: foolstack-db
    restart: always
    volumes:
      - foolframe-db:/var/lib/mysql
    ports:
      - 1347:3306
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
  foolstack-php:
    image: legsplits/foolstack:php
    container_name: foolstack-php
    restart: always
    depends_on:
      - foolstack-db
    volumes:
      - foolframe-temp:/var/www/foolfuuka/public/foolframe
      - foolframe-conf:/var/www/foolfuuka/app/foolz/foolframe/config
  foolstack-nginx:
    image: legsplits/foolstack:nginx
    container_name: foolstack-nginx
    restart: always
    depends_on:
      - foolstack-db
      - foolstack-php
    volumes:
      - foolframe-temp:/var/www/foolfuuka/public/foolframe:ro
      - foolframe-boards:/var/www/foolfuuka/public/foolfuuka/boards:ro
    ports:
      - 1346:80
  foolstack-asagi:
    image: legsplits/foolstack:asagi
    container_name: foolstack-asagi
    restart: always
    depends_on:
      - foolstack-db
    environment:
      - UID=1000
      - GID=1000
      - ASAGI_DB_HOST=some.other.host
    volumes:
      - foolframe-boards:/boards
  foolstack-sphinx:
    image: macbre/sphinxsearch:latest
    container_name: foolstack-sphinx
    restart: always
    depends_on:
      - foolstack-db
    volumes:
    - foolframe-sphinx:/opt/sphinx/index  # directory where sphinx will store index data
#    - ./sphinx.conf:/opt/sphinx/conf/sphinx.conf  # SphinxSE configuration file
    mem_limit: 512m # match indexer.value from sphinx.conf
volumes:
  foolframe-temp:   # FoolFrame generated content on the fly via php
    driver: local
  foolframe-conf:   # Persistent configs
    driver: local
  foolframe-db:     # Percona DB
    driver: local
  foolframe-sphinx: # SphinxDB
    driver: local
  foolframe-boards: # Downloaded images and thumbs
    driver: local
```