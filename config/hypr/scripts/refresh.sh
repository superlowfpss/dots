#!/bin/bash

pkill hyprpaper #swaybg 
sleep 0.1
#swaybg -c 000000 -i /home/andrew/Pictures/wallpapers/drm_panic.png -m center 
hyprpaper
pkill waybar
sleep 0.5
waybar
pkill dunst
dunst
uptime=$(uptime -p)
dunstify "uptime" "$uptime" --icon=meow  -u normal
