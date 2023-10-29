#!/bin/bash

if ! ./find_usb.sh; then
    echo "Could not find USB device"
    exit 1
fi

echo "Compiling for ESP32"
arduino-cli compile \
            -b esp32:esp32:esp32 \
            --output-dir /home/pi/build/ \
            /home/pi/src/piranha/piranha.ino

# upload binary to /dev/esp32
echo "Uploading to /dev/esp32"
arduino-cli upload \
            -p /dev/esp32 \
            -b esp32:esp32:esp32 \
            -i /home/pi/build/piranha.ino.bin \
            -v
