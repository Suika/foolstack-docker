FROM alpine:3.9
EXPOSE 3000
WORKDIR /eve
ENTRYPOINT [ "/eve/entrypoint.sh"]
ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    EVE_UPDATE_DELAY=120 \
    EVE_IMGDIR=/boards \
    EVE_RATELIMIT=1 \
    EVE_DOWNLOAD_MEDIA=True \
    EVE_DOWNLOAD_THUMBS=True \
    EVE_DB_HOST=foolstack-db \
    EVE_DB_USER=asagi \
    EVE_DB_PASS=pass \
    EVE_DB_NAME=asagi \
    EVE_BOARDS=bant,c,e,n,news,out,p,toy,vip,vp,w,wg,wsr

COPY entrypoint.sh .config.py.env /eve/
RUN wget https://github.com/bibanon/eve/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /eve
RUN apk add --update --no-cache  python3 py3-mysqlclient shadow su-exec nodejs libintl
RUN apk add --update --no-cache --virtual eve-build-dep gcc musl-dev python3-dev gettext \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst \
    && pip3 install -r requirements.txt \
    && sed -i '/toScreen(tmp, linefeed)/d' /eve/utils.py \
    && sed -i "s/filename='eve.log',//" /eve/eve.py \
    && apk del eve-build-dep \
    && python3 -m pip uninstall --yes setuptools pip \
    && find / | grep -E "(__pycache__|\.pyc|\.exe|\.pyo$)" | xargs rm -rf
