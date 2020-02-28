#!/bin/bash

# linux
apt-get install avrdude
# Mac
#brew install avrdude

PROGRAM='avrdude'

# Change it to the firmware file path in hex format.
FIRMWARE_HEX='./firmware.hex'

while true; do
  $PROGRAM -v -p atmega2560 -c wiring -P $(ls /dev/ttyUSB*) -b 115200 -D -U flash:w:$FIRMWARE_HEX:i;
  if [ "$?" -eq "0" ]; then
    break;
  fi;
done;