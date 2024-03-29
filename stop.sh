#!/bin/bash

dc=""

docker-compose version >/dev/null 2>/dev/null
if [[ "$?" == "0" ]]; then
    dc="docker-compose"
fi

docker compose version >/dev/null 2>/dev/null
if [[ "$?" == "0" ]]; then
    dc="docker compose"
fi

if [[ "$dc" == "" ]]; then
    echo "Error: functioning docker compose or docker-compose not found"
    exit 1
fi

echo "Stop all services..."
docker stop proxy-proxy-1 \
  kafka-producer \
  q-server-q-server-1 \
  kafka-check-connect-1 \
  kafka-connect-1 \
  kafka-kafka-1 \
  arangodb-arangodb-1 \
  statsd-statsd-1
