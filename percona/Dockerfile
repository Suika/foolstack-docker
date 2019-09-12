FROM healthcheck/percona
COPY docker.cnf /etc/my.cnf.d/docker.cnf
COPY --chown=mysql 1_foolstack-init.sh .foolstack-init.sql.env /docker-entrypoint-initdb.d/
USER root
RUN yum install -y gettext && yum clean all && rm -rf /var/cache/yum
ENV SPHINX_USER=sphinx SPHINX_HOST=foolstack-sphinx% SPHINX_PASS=pass ASAGI_USER=asagi ASAGI_HOST=foolstack-scraper% ASAGI_PASS=pass FOOLFUUKA_USER=foolfuuka FOOLFUUKA_HOST=foolstack-php% FOOLFUUKA_PASS=pass
USER mysql
