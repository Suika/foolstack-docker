FROM alpine:latest
WORKDIR /asagi
RUN apk add git maven openjdk11
RUN git clone https://github.com/desuarchive/asagi.git /asagi
RUN mvn package assembly:single

FROM alpine:latest
ENTRYPOINT ["/asagi/entrypoint.sh"]
CMD ["java", "-XX:+UseParallelGC", "-XX:+UseParallelOldGC", "-verbose:gc", "-jar", "asagi.jar"]
RUN apk --update --no-cache add openjdk11-jre libintl shadow su-exec gettext && cp /usr/bin/envsubst /usr/local/bin/envsubst && apk del gettext
WORKDIR /asagi
RUN addgroup -g 1000 www && \
    adduser -h /asagi -u 1000 -H -S -G 'www' www && \
    mkdir /boards && \
    chown www:www -R /asagi /boards

COPY --from=0 --chown=www /asagi/target/asagi-0.4.0-SNAPSHOT-full.jar /asagi/asagi.jar
COPY --chown=www .asagi.json entrypoint.sh /asagi/

VOLUME /boards

ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    ASAGI_ENGINE=Mysql \
    ASAGI_DB=asagi \
    ASAGI_DB_HOST=foolstack-db \
    ASAGI_DB_USERNAME=asagi \
    ASAGI_DB_PASSWORD=pass \
    ASAGI_DB_CHARSET=utf8mb4 \
    ASAGI_DL_PATH=/boards/ \
    ASAGI_OLD_DIR_STRUCT=false \
    ASAGI_WEBSERVER_GROUP=www \
    ASAGI_THUMB_THREAD_NUM=3 \
    ASAGI_MEDIA_THREAD_NUM=0 \
    ASAGI_NEW_THREADS_THREADS=3 \
    ASAGI_DEL_THREAD_THRESH_PAGE=8 \
    ASAGI_REFRESH_DELAY=30 \
    ASAGI_THROT_API=true \
    ASAGI_THROT_URL=a.4cdn.org \
    ASAGI_THROT_MILLSEC=11100 \
    ASAGI_REFRESH_RATE=10 \
    ASAGI_THREADS='"3": {},"a": {},"aco": {},"adv": {},"an": {},"asp": {},"b": {},"biz": {},"c": {},"cgl": {},"ck": {},"cm": {},"co": {},"d": {},"diy": {},"e": {},"f": {},"fa": {},"fit": {},"g": {},"gd": {},"gif": {},"h": {},"hc": {},"hm": {},"his": {},"hr": {},"i": {},"ic": {},"int": {},"jp": {},"k": {},"lgbt": {},"lit": {},"m": {},"mlp": {},"mu": {},"n": {},"news": {},"o": {},"out": {},"p": {},"po": {},"pol": {},"qa": {},"qst": {},"r": {},"r9k": {},"s": {},"s4s": {},"sci": {},"soc": {},"sp": {},"t": {},"tg": {},"toy": {},"trash": {},"trv": {},"tv": {},"u": {},"v": {},"vg": {},"vp": {},"vr": {},"w": {},"wg": {},"wsg": {},"wsr": {},"x": {},"y": {}'
