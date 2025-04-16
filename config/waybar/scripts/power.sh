#!/bin/bash
case "$1" in
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
esac
