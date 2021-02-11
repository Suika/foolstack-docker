#!/usr/bin/env bash
## startup.sh
## Startup foolstack in the proper order

echo "startup.sh: Starting up foolstack SeaweedFS + Torako + Ayase..."
echo "startup.sh: This takes at least 1 minutes, go grab a coffee." 

## Startup seaweedfs + database containers
echo "startup.sh: First docker-compose (weed+mysql)..."
docker-compose -f "docker-compose.yml" up -d 
echo "startup.sh: First docker-compose returned"

sleep 30 ## Safety margin for containers to startup properly.

## Ensure S3 buckets exist:
echo "startup.sh: Creating buckets..."
docker exec -i  seaweed-master /usr/bin/weed shell -master=seaweed-master:9333 -filer=seaweed-filer:8888 <<EOF
s3.bucket.create -name asagi-thumbs
s3.bucket.create -name asagi-images
exit
EOF
echo "startup.sh: Creating buckets returned."

sleep 30 ## Safety margin for bucket creation.

## Add torako and ayase containers to established group:
echo "startup.sh: Second docker-compose (torako+ayase)..."
docker-compose -f "docker-compose.yml" -f "docker-compose.ayase.yml" up -d
echo "startup.sh: Second docker-compose returned"

echo "startup.sh: Foolstack should now be running." 
echo "startup.sh: Finsihed." 