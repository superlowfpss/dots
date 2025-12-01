#!/bin/bash

dunstify "Clip Saved!" --icon=video-x-generic  -u critical
hyprctl dispatch sendshortcut ",F17,class:^(com\\.obsproject\\.Studio)"

#I could just do a passthrough for the f17 key
#But I think receiving notifications will be cooler :3
