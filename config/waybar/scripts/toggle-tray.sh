#!/bin/bash
WAYBAR_TRAY_PID=$(pgrep -f "waybar -c tray-config.jsonc")

if [ -z "$WAYBAR_TRAY_PID" ]; then
    waybar -c ~/.config/waybar/configs/tray-config.jsonc &
else
    kill $WAYBAR_TRAY_PID
fi
