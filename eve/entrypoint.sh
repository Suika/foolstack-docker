#!/bin/sh

USER_ID=${UID}
GROUP_ID=${GID}

export SCRAPER_BOARDS=$(echo $SCRAPER_BOARDS | sed "s/^/'/;s/$/'/;s/\s*,\s*/','/g")

if [ ! -f "/eve/config.py" ]; then
  envsubst < /eve/.config.py.env > /eve/config.py
fi

echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
chown ${USER_ID}:${GROUP_ID} -R /eve
chown ${USER_ID}:${GROUP_ID} ${SCRAPER_IMGDIR}

exec su-exec ${USER_ID}:${GROUP_ID} "$@"
