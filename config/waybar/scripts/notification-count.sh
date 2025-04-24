#!/bin/sh
COUNT=$(dunstctl count history)
echo "{\"text\":\"\", \"tooltip\":\"Notifications: $COUNT\"}"
