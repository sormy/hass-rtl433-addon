# Home Assistant RTL433 Addon

## About

This addon spawns rtl_433 that decodes radio signals and emits them as mqtt
topic, also spawns rtl_433_mqtt_hass helper that reads this mqtt topic and
translates into Home Assistant friendly mqtt topic with auto discovery mqtt
topic.

It is alternative to: https://github.com/pbkhrv/rtl_433-hass-addons

Main difference is that this rtl433 addon combines both rtl_433 process and
rtl_433_mqtt_hass process inside one container. Also this rtl433 addon allows to
configure processes using command line arguments rather than config files.

This addon mainly was built to simplify migration from command line based
configuration in systemd straight to home assistant addon + lock to specific
version using different branches on this repo due to backward incompatible
changes for entity id generation between 22.11 and 23.11.

## Versioning

Version A.B.C for this addon represents:

- A - version of this addon
- B.C - version of rtl433

## Requirements

RTL_433 compatible USB SDR dongle and Home Assistant MQTT addon.

## Installation

1. Ensure you have RTL-SDR dongle connected to Home Assistant box.
2. Enable "Mosquitto broker" addon and enable MQTT integration in Home
   Assistant.
3. Create MQTT user with password in "Mosquitto broker" addon (Options/Logins):
   ```yaml
   - username: rtl433
     password: secret_change_me
   ```
4. Follow standard procedure https://www.home-assistant.io/addons/ and add this
   plugin by URL https://github.com/sormy/hass-rtl433-addon. You can also add
   #version in the end of URL to switch versions of addon.
5. Set username/password in RTL433 addon configuration for both rtl433 and
   rtl433_mqtt_hass.
6. Start addon.
7. Devices nearby must appear in Home Assistant.

For more detailed configuration please refer to
<https://github.com/merbanan/rtl_433> documentation.

It is highly recommended to enable only protocols you wanted to decode to reduce
cpu consumption by rtl433 daemon.

Example "enable only Acurite sensors":

```yaml
rtl433_opts:
  "-C si -M utc -R 40 -F
  mqtt://core-mosquitto:1883,user=rtl433,pass=secret_change_me,retain=0"
rtl433_mqtt_hass_opts:
  "--host core-mosquitto --port 1883 --user rtl433 --password secret_change_me"
```

## Testing

Check if docker image is buildable:

```sh
docker build \
  --build-arg BUILD_FROM="homeassistant/aarch64-base:latest" \
  -t local/hass-rtl433-addon \
  rtl433
```

Upload to homeassistant box for local installation (ssh enabled):

```sh
rsync --recursive --verbose --delete rtl433 root@homeassistant:/addons/
```

## License

MIT
