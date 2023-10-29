#!/bin/bash

REQUESTED_VENDOR_ID=1a86
REQUESTED_PRODUCT_ID=55d4
SYMLINK_NAME=esp32
USB_DEVICE_FOUND=0

for device in $(find /sys/bus/usb/devices/ -maxdepth 1 -type l); do
  if [ -e "$device/idVendor" ] && [ -e "$device/idProduct" ]; then
    vendor_id=$(cat "$device/idVendor")
    product_id=$(cat "$device/idProduct")

    if [ "$vendor_id" == "$REQUESTED_VENDOR_ID" ] && [ "$product_id" == "$REQUESTED_PRODUCT_ID" ]; then
      echo "Found instance of device $vendor_id:$product_id"
      bus=$(cat "$device/busnum")
      port=$(cat "$device/devpath")

      # Look for the associated tty device
      for tty in $(find "$device/$bus-$port:1.0/tty/" -name "tty*" -type d); do
        # Continue if name is exactly tty - false positive
        if [ "$tty" == "$device/$bus-$port:1.0/tty/" ]; then
          continue
        fi

        # Get the name of the tty device
        tty_name=$(basename "$tty")
        echo "Found tty device $tty_name"

        # Check if the corresponding device file exists in /dev
        if [ -e "/dev/$tty_name" ]; then
          echo "Found device file /dev/$tty_name"
          # Create a symlink to the device file in /dev
          ln -s "/dev/$tty_name" "/dev/$SYMLINK_NAME"
          echo "Created symlink /dev/$SYMLINK_NAME -> /dev/$tty_name"
          USB_DEVICE_FOUND=1
        else
          echo "Could not find device file /dev/$tty_name"
        fi
      done
    fi
  fi
done

# Exit based on USB device found or not
if [ $USB_DEVICE_FOUND -eq 1 ]; then
  exit 0
else
  exit 1
fi
