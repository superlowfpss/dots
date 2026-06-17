#!/bin/sh
pgrep wofi > /dev/null 2>&1 && killall wofi || (cliphist list | wofi --width=500 --height=300 --dmenu --pre-display-cmd "echo '%s' | cut -f 2" | cliphist decode | wl-copy)
