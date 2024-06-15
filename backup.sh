#!/bin/bash
echo $1 $2

cd ../$1
docker compose down
echo "down"
docker run --rm \
      -v "$2":/backup-volume \
      -v "$(pwd)":/backup \
      busybox \
      tar -zcvf /backup/my-backup.tar.gz /backup-volume

docker compose up -d
