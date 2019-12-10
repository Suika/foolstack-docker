FROM alpine:3.9
EXPOSE 3000
WORKDIR /eve
ENTRYPOINT [ "sh", "/eve/entrypoint.sh"]
CMD ["python3", "/eve/eve.py"]

ADD https://api.github.com/repos/bibanon/eve/git/refs/heads/master /version.json
RUN wget https://github.com/bibanon/eve/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /eve && rm /eve/config.py
RUN apk add --update --no-cache  python3 py3-mysqlclient su-exec nodejs libintl
RUN apk add --update --no-cache --virtual eve-build-dep gcc musl-dev python3-dev gettext \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst \
    && pip3 install -r requirements.txt \
    && apk del eve-build-dep \
    && mkdir -p /boards \
    && python3 -m pip uninstall --yes setuptools pip \
    && find / | grep -E "(__pycache__|\.pyc|\.exe|\.pyo$)" | xargs rm -rf

COPY entrypoint.sh .config.py.env /eve/

VOLUME /boards

ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    SCRAPER_DB_HOST=foolstack-db \
    SCRAPER_DB_NAME=asagi \
    SCRAPER_DB_USER=asagi \
    SCRAPER_DB_PASS=pass \
    SCRAPER_IMGDIR=/boards \
    SCRAPER_BORADS_DELAY=120 \
    SCRAPER_API_DELAY=1 \
    SCRAPER_DOWNLOAD_MEDIA=True \
    SCRAPER_DOWNLOAD_THUMBS=True \
    SCRAPER_BOARDS=bant,c,e,n,news,out,p,toy,vip,vp,w,wg,wsr
