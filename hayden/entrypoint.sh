#!/bin/sh

set -xe

if hash su-exec 2>/dev/null; then
  export RUNEXEC=su-exec
else
  export RUNEXEC=gosu
fi

USER_ID=${UID}
GROUP_ID=${GID}

export SCRAPER_BOARDS=$(echo $SCRAPER_BOARDS | sed "s/^/\"/;s/$/\"/;s/\s*,\s*/\",\"/g")

if [ -z "$SCRAPER_PROXY" ]; then
    export SCRAPER_PROXY_CONF=""
else
    export SCRAPER_PROXY_CONF=$( envsubst <<\EOF
  "proxies" : [
      {
          "type" : "${SCRAPER_PROXY_TYPE}",
          "url" : "${SCRAPER_PROXY_URL}",
          "username" : "${SCRAPER_PROXY_USER}",
          "password" : "${SCRAPER_PROXY_PASS}"
      }
  ],
EOF
)
fi

if [ ! -f "/hayden/config.json" ]; then
  envsubst < /hayden/.config.json.env > /hayden/config.json
fi

echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
chown ${USER_ID}:${GROUP_ID} -R /hayden
chown ${USER_ID}:${GROUP_ID} ${SCRAPER_IMGDIR}

exec ${RUNEXEC} ${USER_ID}:${GROUP_ID} "$@"
