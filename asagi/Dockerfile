FROM alpine:latest
WORKDIR /asagi
RUN apk add git maven openjdk11
ADD https://api.github.com/repos/desuarchive/asagi/git/refs/heads/master /version.json
RUN git clone https://github.com/desuarchive/asagi.git /asagi
RUN mvn package assembly:single

FROM ubuntu:rolling
ENTRYPOINT ["sh", "/asagi/entrypoint.sh"]
CMD ["java", "-XX:+UseParallelGC", "-XX:+UseParallelOldGC", "-verbose:gc", "-jar", "asagi.jar"]
WORKDIR /asagi

RUN apt-get update && apt-get -y install openjdk-11-jre-headless gettext-base gosu && rm -rf /var/lib/apt/lists/*
RUN addgroup --system --gid 1000 www && \
    adduser --system --home /asagi --uid 1000 --no-create-home --ingroup 'www' www && \
    mkdir /boards && \
    chown www:www -R /asagi /boards

COPY --from=0 --chown=www /asagi/target/asagi-0.4.0-SNAPSHOT-full.jar /asagi/asagi.jar
COPY --chown=www .asagi.json.env entrypoint.sh /asagi/

VOLUME /boards

ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    SCRAPER_DB_HOST=foolstack-db \
    SCRAPER_DB_NAME=asagi \
    SCRAPER_DB_USER=asagi \
    SCRAPER_DB_PASS=pass \
    SCRAPER_DB_CHARSET=utf8mb4 \
    SCRAPER_DB_ENGINE=Mysql \
    SCRAPER_IMGDIR=/boards/ \
    SCRAPER_ASAGI_OLDSTRUCT=false \
    SCRAPER_ASAGI_WEBGRP=www \
    SCRAPER_THUMB_THREADS=3 \
    SCRAPER_MEDIA_THREADS=0 \
    SCRAPER_THREAD_THREADS=3 \
    SCRAPER_API_THROTTLE=true \
    SCRAPER_API_URL=a.4cdn.org \
    SCRAPER_API_DELAY=11100 \
    SCRAPER_BORADS_DELAY=10 \
    SCRAPER_REFRESH_DELAY=30 \
    SCRAPER_DEL_THREAD_THRESH_PAGE=8 \
    SCRAPER_BOARDS=bant,c,e,n,news,out,p,toy,vip,vp,w,wg,wsr