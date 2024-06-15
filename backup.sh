#!/bin/bash
echo USAGE: ./backup.sh [CONTAINER] [VOLUME], e.g. ./backup.sh Grafana grafana-prod_grafana_data
echo $1 $2
CURPATH=$(pwd)

cd ../$1
echo switching from $CURPATH to $(pwd) and shuting down container $1
docker compose down

echo running backup
docker run --rm \
      -v "$2":/backup-volume \
      -v "$CURPATH":/backup \
      busybox \
      tar -zcvf /backup/backup/$1_$(date '+%Y-%m-%d_%H:%M:%S').tar.gz /backup-volume

echo starting up container $1
docker compose up -d
