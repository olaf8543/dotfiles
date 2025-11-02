#!/bin/bash
# Get the WiFi device name
DEVICE=$(nmcli -t device | grep wifi | cut -d: -f1 | head -1)

if [ -n "$DEVICE" ]; then
    nmcli device disconnect "$DEVICE" && nmcli device connect "$DEVICE"
    echo "WiFi device '$DEVICE' reconnected"
else
    echo "No WiFi device found"
fi
nmcli connection show
