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

echo "Update Kafka"
$dc -f deploy/kafka/docker-compose.yml build --no-cache
$dc -f deploy/kafka/docker-compose.yml up -d --force-recreate

echo "Update Node"
$dc -f deploy/kafka-producer/docker-compose.yml build --no-cache
$dc -f deploy/kafka-producer/docker-compose.yml up -d --force-recreate
