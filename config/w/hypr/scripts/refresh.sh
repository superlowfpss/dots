#!/bin/bash

killall hyprpaper
sleep 0.1
hyprpaper
pkill waybar
sleep 0.5
waybar
