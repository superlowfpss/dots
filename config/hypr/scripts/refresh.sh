#!/bin/bash

pkill hyprpaper
sleep 0.1
hyprpaper
pkill waybar
sleep 0.5
waybar
pkill dunst
dunst
uptime=$(uptime -p)
dunstify "uptime" "$uptime" --icon=meow  -u normal
