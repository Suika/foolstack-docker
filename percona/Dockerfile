FROM percona:ps-5.7
USER root
COPY docker-healthcheck /usr/local/bin/
RUN yum install -y gettext && yum clean all && rm -rf /var/cache/yum && chmod +x /usr/local/bin/docker-healthcheck
USER mysql
COPY docker.cnf /etc/my.cnf.d/docker.cnf
COPY --chown=mysql 1_foolstack-init.sh 2_foolstack-init.sql .foolstack-init.sql.env /docker-entrypoint-initdb.d/
HEALTHCHECK CMD ["docker-healthcheck"]
ENV DB_SPHINX_USER=sphinx \
    DB_SPHINX_HOST=foolstack-sphinx% \
    DB_SPHINX_PASS=pass \
    DB_SPHINX_NAME=sphinx \
    DB_ASAGI_USER=asagi \
    DB_ASAGI_HOST=foolstack-scraper% \
    DB_ASAGI_PASS=pass \
    DB_ASAGI_NAME=asagi \
    DB_FOOLFUUKA_USER=foolfuuka \
    DB_FOOLFUUKA_HOST=foolstack-php% \
    DB_FOOLFUUKA_PASS=pass \
    DB_FOOLFUUKA_NAME=foolfuuka
