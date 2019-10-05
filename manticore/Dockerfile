FROM manticoresearch/manticore:latest

RUN apt-get update && apt-get -y install mariadb-client && rm -rf /var/lib/apt/lists/*
COPY sphinx.sh /etc/sphinxsearch/sphinx.conf
VOLUME /etc/sphinxsearch

ENV DB_HOST=foolstack-db \
    DB_PORT=3306 \
    DB_SPHINX_USER=sphinx \
    DB_SPHINX_PASS=pass \
    DB_FOOLFUUKA_PASS=pass \
    DB_FOOLFUUKA_NAME=foolfuuka \
    DB_ASAGI_NAME=asagi