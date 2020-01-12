FROM alpine:3.10 as builder

# https://docs.manticoresearch.com/latest/html/installation.html#required-tools
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=manticoresearch
# http://moar.sshilko.com/2018/10/06/Scaling-sphinxsearch/
# https://gist.github.com/sshilko/b1a675ad2bf364ccb92b0db47191d923
# https://github.com/manticoresoftware/manticoresearch/issues/126
# https://github.com/manticoresoftware/manticoresearch/issues/128

ARG RELEASE=manticore-3.2.2
WORKDIR /build

RUN apk add --update --no-cache \
    git             \
    cmake           \
    make            \
    g++             \
    bison           \
    flex            \
    mariadb-dev     \
    expat-dev       \
    asio-dev        \
    mariadb-client  \
    postgresql-dev

RUN git clone -b ${RELEASE} --single-branch --depth=1  https://github.com/manticoresoftware/manticore.git /build && \
    mkdir -p /build/build /manticore && \
    cd build && \
    cmake \
        -D SPLIT_SYMBOLS=1 \
        -D WITH_MYSQL=ON \
        -D WITH_PGSQL=ON \
        -D WITH_RE2=ON \
        -D WITH_STEMMER=ON \
        -D DISABLE_TESTING=ON \
        -D CMAKE_INSTALL_PREFIX=/usr \
        -D CONFFILEDIR=/etc/manticore \
        -D SPHINX_TAG=release .. && \
    make -j$(nproc) searchd indexer indextool && \
    mv /build/build/src/indexer /build/build/src/searchd /build/build/src/indextool /manticore

FROM alpine:3.10
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
CMD ["searchd", "--nodetach"]
RUN apk add --no-cache \
            mariadb-client \
            mariadb-connector-c-dev \
            postgresql-libs \
            expat \
            su-exec

COPY --from=builder /manticore   /usr/bin/
COPY sphinx.sh /etc/manticore/manticore.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
VOLUME /var/lib/manticore /etc/manticore /var/log/manticore

ENV UID=${UID:-1000} \
    GID=${GID:-1000} \
    DB_HOST=foolstack-db \
    DB_PORT=3306 \
    DB_SPHINX_USER=sphinx \
    DB_SPHINX_PASS=pass \
    DB_FOOLFUUKA_PASS=pass \
    DB_FOOLFUUKA_NAME=foolfuuka \
    DB_ASAGI_NAME=asagi \
    MEM_LIMIT=512M \
    WRITE_BUFFER=8M \
    MAX_FILE_FIELD_BUFFER=32M \
    MAX_XMLPIPE2_FIELD=4M \
    READ_TIMEOUT=5 \
    CLIENT_TIMEOUT=300 \
    MAX_CHILDREN=0 \
    SEAMLESS_ROTATE=1 \
    PREOPEN_INDEXES=1 \
    UNLINK_OLD=1 \
    MAX_PACKET_SIZE=32M \
    MAX_FILTERS=256 \
    MAX_FILTER_VALUES=4096 \
    LISTEN_BACKLOG=25 \
    MAX_BATCH_QUERIES=32 \
    THREAD_STACK=128K
