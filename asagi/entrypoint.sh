#!/bin/sh

envsubst < /asagi/.asagi.json > /asagi/asagi.json

set -o pipefail

USER_ID=${UID}
GROUP_ID=${GID}

usermod -u ${USER_ID} $(id $( ( getent passwd ${USER_ID} || echo "www" ) | cut -d : -f 1) -n -u)
groupmod -g ${GROUP_ID} $(id $( ( getent group ${GROUP_ID} || echo "www" ) | cut -d : -f 1) -n -g)


if [ $USER_ID !=  1000 ] || [ $GROUP_ID != 1000 ]; then
  echo "Setting permissions to UID/GID: ${USER_ID}/${GROUP_ID}"
  chown ${USER_ID}:${GROUP_ID} -R /asagi
  chown ${USER_ID}:${GROUP_ID} /boards
  
fi

exec su-exec ${USER_ID}:${GROUP_ID} "$@"
