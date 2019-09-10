#!/bin/sh
envsubst < /docker-entrypoint-initdb.d/.foolstack-init.sql.env > /docker-entrypoint-initdb.d/2_foolstack-init.sql
