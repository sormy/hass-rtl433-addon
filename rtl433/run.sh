#!/usr/bin/with-contenv bashio
# shellcheck disable=SC1008,SC1091

source .venv/bin/activate

RTL433_OPTS="$(bashio::config rtl433_opts)"
RTL433_MQTT_HASS_OPTS="$(bashio::config rtl433_mqtt_hass_opts)"

rtl_433 $RTL433_OPTS > /dev/fd/1 2>&1 &
rtl_433_mqtt_hass $RTL433_MQTT_HASS_OPTS > /dev/fd/1 2>&1 &

wait -n
exit $?
