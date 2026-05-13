#!/bin/bash

DEFAULT_SOURCE=$(pactl get-default-source)
MUTE_STATE=$(pactl list sources | grep -A 10 "Name: $DEFAULT_SOURCE" | grep "Mute:" | awk '{print $2}')

if [[ "$MUTE_STATE" == "yes" ]]; then
    pactl set-source-mute "$DEFAULT_SOURCE" 0
    dunstify "Microphone Unmuted" --icon=audio-input-microphone-available-symbolic -u normal
else
    pactl set-source-mute "$DEFAULT_SOURCE" 1
    dunstify "Microphone Muted" --icon=audio-input-microphone-muted-symbolic -u critical
fi
