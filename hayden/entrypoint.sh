#!/bin/sh

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

envsubst < /hayden/.config.json.env > /hayden/config.json

echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
chown ${USER_ID}:${GROUP_ID} -R /hayden
chown ${USER_ID}:${GROUP_ID} ${SCRAPER_IMGDIR}

exec su-exec ${USER_ID}:${GROUP_ID} "$@"
