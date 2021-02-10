#!/usr/bin/env bash
## mkdirs.sh
## Ensure required dirs exist.

# cd /o/

## seaweed-master
mkdir -vp ./seaweedfs/master/data
chmod -v "u=rwx,g=rwx,o=rwx" ./seaweedfs/master/ ./seaweedfs/master/data

## seaweed-volume-1
mkdir -vp ./seaweedfs/seaweed-volume-1
chmod -v "u=rwx,g=rwx,o=rwx" ./seaweedfs/seaweed-volume-1

## seaweed-filer
mkdir -vp ./seaweedfs/filer/filerldb2
chmod -v "u=rwx,g=rwx,o=rwx" ./seaweedfs/filer ./seaweedfs/filer/filerldb2
