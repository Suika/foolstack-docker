FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder
ARG ARCH=linux-musl-x64
ADD https://api.github.com/repos/bbepis/Hayden/git/refs/heads/master /version.json
RUN git clone https://github.com/bbepis/Hayden /build && cd /build && dotnet publish Hayden -r $ARCH -o /hayden

FROM alpine:latest
ENTRYPOINT ["sh", "/hayden/entrypoint.sh"]
CMD ["/hayden/Hayden", "/hayden/config.json"]
WORKDIR /hayden

RUN apk add --update --no-cache libstdc++ glib icu-libs libcurl su-exec libintl && \
    apk add --update --no-cache gettext && cp /usr/bin/envsubst /usr/local/bin/envsubst && apk del gettext && \
    mkdir /boards
COPY --from=builder /hayden /hayden
COPY entrypoint.sh .config.json.env /hayden/

VOLUME /boards

ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    SCRAPER_DB_HOST=foolstack-db \
    SCRAPER_DB_PORT=3306 \
    SCRAPER_DB_NAME=asagi \
    SCRAPER_DB_USER=asagi \
    SCRAPER_DB_PASS=pass \
    SCRAPER_DB_CHARSET=utf8mb4 \
    SCRAPER_DB_IGNORE_PREPARE=false \
    SCRAPER_DB_TYPE=Asagi \
    SCRAPER_TYPE=4chan \
    SCRAPER_BORADS_DELAY=30 \
    SCRAPER_API_DELAY=0.8 \
    SCRAPER_PROXY_TYPE=socks \
    SCRAPER_PROXY_URL=http://localhost:3182 \
    SCRAPER_PROXY_USER=UGAYNAO \
    SCRAPER_PROXY_PASS=2big4u \
    SCRAPER_IMGDIR=/boards \
    SCRAPER_DOWNLOAD_MEDIA=true \
    SCRAPER_DOWNLOAD_THUMBS=true \
    SCRAPER_DB_POOLSIZE=12 \
    SCRAPER_BOARDS=bant,c,e,n,news,out,p,toy,vip,vp,w,wg,wsr
