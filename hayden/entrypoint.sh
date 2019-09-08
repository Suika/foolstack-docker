#!/bin/sh

set -xe

USER_ID=${UID}
GROUP_ID=${GID}

export SCRAPER_BOARDS=$(echo $SCRAPER_BOARDS | sed "s/^/\"/;s/$/\"/;s/\s*,\s*/\",\"/g")

envsubst < /hayden/.config.json.env > /hayden/config.json

echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
chown ${USER_ID}:${GROUP_ID} -R /hayden
chown ${USER_ID}:${GROUP_ID} ${SCRAPER_IMGDIR}

exec su-exec ${USER_ID}:${GROUP_ID} /hayden $@
