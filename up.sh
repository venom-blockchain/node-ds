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

echo "Starting Statsd"
$dc -f deploy/statsd/docker-compose.yml up --build -d

echo "Starting ArangoDB"
$dc -f deploy/arangodb/docker-compose.yml up --build -d


echo "Starting Kafka & Kafka Connect"
$dc -f deploy/kafka/docker-compose.yml up --build -d


echo "Starting Q-Server"
$dc -f deploy/q-server/docker-compose.yml up --build -d


echo "Starting Node"
$dc -f deploy/kafka-producer/docker-compose.yml up --build -d

echo "Starting reverse proxy"
$dc -f deploy/proxy/docker-compose.yml up -d
