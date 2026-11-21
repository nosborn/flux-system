#!/bin/bash
#
# Runs as root on every container start, after plugin install and
# before Homebridge starts.
#
set -eu

# Demote homebridge-unifi-occupancy-lite per-refresh logs from info to
# debug. State changes (presence, occupied/empty) stay at info.
# e.g. this.log.info(`Residents at home: ...  ->  this.log.debug(`Residents...
PLATFORM_JS=/homebridge/node_modules/homebridge-unifi-occupancy-lite/dist/platform.js

if [ -f "${PLATFORM_JS}" ]; then
  sed -i \
    -e 's/this\.log\.info(`Device \${device\.name}/this.log.debug(`Device ${device.name}/' \
    -e 's/this\.log\.info(`Processing \${this\.wifiPoints\.length}/this.log.debug(`Processing ${this.wifiPoints.length}/' \
    -e 's/this\.log\.info(`Access points found:/this.log.debug(`Access points found:/' \
    -e 's/this\.log\.info(`Processing WiFi Point:/this.log.debug(`Processing WiFi Point:/' \
    -e 's/this\.log\.info(`WiFi Point \${wifiPoint\.name} matched to AP:/this.log.debug(`WiFi Point ${wifiPoint.name} matched to AP:/' \
    -e 's/this\.log\.info(`WiFi Point \${wifiPoint\.name}: devices at AP/this.log.debug(`WiFi Point ${wifiPoint.name}: devices at AP/' \
    -e 's/this\.log\.info(`WiFi Point \${wifiPoint\.name} status:/this.log.debug(`WiFi Point ${wifiPoint.name} status:/' \
    -e 's/this\.log\.info(`Residents at home:/this.log.debug(`Residents at home:/' \
    "${PLATFORM_JS}"
fi
