#!/usr/bin/env bash

log() {
  echo "* $1" >&2
}


CORDOVA_TELEMETRY_OFF=${CORDOVA_TELEMETRY_OFF:-'0'}
export CORDOVA_TELEMETRY_OFF
[[ $CORDOVA_TELEMETRY_OFF != '0' ]] && cordova telemetry off > /dev/null


log "JDK:     $(java -version 2>&1 | grep version)"
log "Gradle:  $(gradle -v | grep ^Gradle | sed 's/Gradle //')"
log "Cordova: $(cordova --no-telemetry -v)"

exec "$@"
