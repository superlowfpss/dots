#!/bin/bash

hyprlock -c ~/.config/hypr/hyprlock.conf &

sleep 1

systemctl suspend
