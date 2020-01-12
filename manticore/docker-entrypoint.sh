#!/bin/sh
set -e

USER_ID=${UID}
GROUP_ID=${GID}

#addgroup --gid ${GROUP_ID} --system manticore
#adduser --uid ${USER_ID} --system --ingroup manticore manticore

# first arg is `h` or some `--option`
if [ "${1#-}" != "$1" ]; then
        set -- searchd "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'searchd'  -a "$(id -u)" = '0' ]; then
        find /var/lib/manticore /var/log/manticore /etc/manticore -exec chown ${USER_ID}:${GROUP_ID} '{}' +
        exec su-exec ${USER_ID} sh "$0" "$@"
fi

exec "$@"
