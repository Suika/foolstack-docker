#!/bin/sh
export CREATED_AT=$(date +%s)
envsubst < /docker-entrypoint-initdb.d/.foolstack-init.sql.env > /docker-entrypoint-initdb.d/2_foolstack-init.sql
sed -i 's/DOESNOTESCAPEDONTWANTTOFINDOUTWHY/\$2y\$10\$RsNJ8iGq41EHS7X3\.RKBgumUESCLla0YeokroI28Q9JqBZMkB0qoS/' /docker-entrypoint-initdb.d/2_foolstack-init.sql