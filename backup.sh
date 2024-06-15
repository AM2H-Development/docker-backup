#!/bin/bash
PATH=$(pwd)

cd ../$1
docker compose down
echo "down"
docker run --rm \
      -v "$2":/backup-volume \
      -v "$PATH":/backup \
      busybox \
      tar -zcvf /backup/$(date +%F_%T).tar.gz /backup-volume

docker compose up -d
