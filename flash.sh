#!/bin/bash

# Set the program to flash the .hex
PROGRAM='avrdude'

# Change it to the default firmware file path in hex format.
DEFAULT_FIRMWARE_HEX='./firmware.hex'

# Function: Flash the selected .hex-file
flash_hex() {
while true; do
  $PROGRAM -v -p atmega2560 -c wiring -P $(ls /dev/ttyUSB*) -b 115200 -D -U flash:w:$FIRMWARE_HEX:i;
  if [ "$?" -eq "0" ]; then
    break;
  fi;
done;
}

# Query whether commandline-arguments have been set
if [ "$#" -gt "1" ]; then
  echo "More than one argument was set"
elif [ "$#" -eq "1" ]; then
  echo "File-argument was set to \""$1"\""
  if [ "${1##*.}" != "hex" ]; then
    echo "Invalid file extension!"
  else
    FIRMWARE_HEX=$1
    flash_hex
  fi
else
  echo "No file-argument was set -> taking default \""$DEFAULT_FIRMWARE_HEX"\""
  FIRMWARE_HEX=$DEFAULT_FIRMWARE_HEX
  flash_hex
fi
