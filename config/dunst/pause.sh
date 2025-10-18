#!/bin/bash

if dunstctl is-paused | grep -q "true"; then
    # If paused, unpause it
    dunstctl set-paused false
    dunstify --icon=no "Notifications are now enabled"
else
    dunstify --icon=no "Notifications are now paused" -u critical
    sleep 0.5
    dunstctl set-paused true
fi
