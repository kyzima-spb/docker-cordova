#!/usr/bin/env bash


if ! getent passwd "$(id -u)" > /dev/null 2>&1; then
  export HOME=/tmp
fi

CORDOVA_TELEMETRY_OFF=${CORDOVA_TELEMETRY_OFF:-'0'}
export CORDOVA_TELEMETRY_OFF
[[ $CORDOVA_TELEMETRY_OFF != '0' ]] && cordova telemetry off > /dev/null


exec "$@"
