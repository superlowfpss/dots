#!/bin/bash

query=$(wofi --dmenu --prompt "search with google" --width 900 --height 35)

if [ -z "$query" ]; then
    exit 0
fi

encoded_query=$(echo "$query" | sed 's/ /+/g')
current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
browser_ws=$(hyprctl clients -j | jq -r '.[] | select(.class | test("firefox"; "i")) | .workspace.id' | head -1)

if [ -n "$browser_ws" ] && [ "$browser_ws" != "$current_ws" ]; then
    hyprctl dispatch workspace "$browser_ws"
    sleep 0.2
fi

xdg-open "https://www.google.com/search?q=$encoded_query"
