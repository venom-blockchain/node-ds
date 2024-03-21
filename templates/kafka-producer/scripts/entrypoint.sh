#!/bin/bash -eEx

echo "INFO: kafka-producer startup..."

echo "INFO: CONFIGS_PATH = ${CONFIGS_PATH}"
echo "INFO: \$1 = $1"

if [ "$1" = "bash" ]; then
    tail -f /dev/null
else
    exec /app/ton-kafka-producer --config ${CONFIGS_PATH}/config.yaml \
    --global-config ${CONFIGS_PATH}/ton-global.config.json
fi

echo "INFO: kafka-producer startup... DONE"
