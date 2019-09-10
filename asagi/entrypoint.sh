#!/bin/sh

USER_ID=${UID}
GROUP_ID=${GID}

export SCRAPER_BOARDS=$(echo $SCRAPER_BOARDS | sed "s/^/\"/;s/$/\"\:\{\}/;s/\s*,\s*/\"\:\{\},\"/g")

envsubst < /asagi/.asagi.json.env > /asagi/asagi.json

echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
chown ${USER_ID}:${GROUP_ID} -R /asagi
chown ${USER_ID}:${GROUP_ID} ${SCRAPER_IMGDIR}

exec gosu ${USER_ID}:${GROUP_ID} "$@"
