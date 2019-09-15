#!/bin/sh
export CREATED_AT=$(date +%s)
envsubst < /docker-entrypoint-initdb.d/.foolstack-init.sql.env > /docker-entrypoint-initdb.d/2_foolstack-init.sql