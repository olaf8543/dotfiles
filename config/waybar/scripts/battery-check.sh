#!/bin/bash

BAT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)
STATE_FILE="/tmp/low_battery_notified"

# If battery is low and discharging
if [ "$BAT_STATUS" = "Discharging" ] && [ "$BAT_CAPACITY" -le 20 ]; then
    # Only send notification if it hasn’t been sent already
    if [ ! -f "$STATE_FILE" ]; then
        export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
        export DISPLAY=:0
        dunstify -u critical "BATTERY LOW: ${BAT_CAPACITY}%"
        touch "$STATE_FILE"  # Create a state file to block future notifications
    fi
else
    # Reset the notification state if battery is charging or above 20%
    rm -f "$STATE_FILE"
fi
