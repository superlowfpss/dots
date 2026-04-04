#!/usr/bin/env python3

import gi
import sys
import os
import json
import re
import subprocess

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

def resolveIconPath(iconName):
    iconTheme = Gtk.IconTheme.get_default()
    iconFile = iconTheme.lookup_icon(iconName.lower(), 32, 0)
    if iconFile:
        return iconFile.get_filename()
    else:
        return ""

def mapWindow(w):
    workspace_id = w["workspace"]["id"]
    # Format: w-1 App Name
    return "img:%s:text:w-%d %s" % (resolveIconPath(w["class"]), workspace_id, w["title"])

windows = json.loads(os.popen("hyprctl -j clients").read())
filtered_windows = list(filter(lambda w: w["workspace"]["id"] != -1, windows))
# Sort windows by workspace ID for better organization
filtered_windows.sort(key=lambda w: w["workspace"]["id"])
mapped_windows = list(map(mapWindow, filtered_windows))

# Use subprocess.run instead of os.popen to avoid shell interpretation issues
wofi_process = subprocess.run(
    ["wofi", "--insensitive", "--prompt", "rawr", "--width=600", "--height=300", "-S", "dmenu"],
    input="\n".join(mapped_windows),
    capture_output=True,
    text=True
)

selected_window = wofi_process.stdout.strip()

print("selected_window: %s" % (selected_window))

if selected_window:
    # Extract just the title part (after the "w-X " prefix)
    # The pattern looks for "w-<number> " at the beginning and captures everything after
    match = re.search(r"w-\d+\s+(.+)", selected_window)
    if match:
        selected_title = match.group(1)
        
        # Find the window by matching the title
        for w in filtered_windows:
            if w["title"] == selected_title:
                addr = w["address"]
                os.system("hyprctl dispatch focuswindow address:%s" % (addr))
                break
        else:
            print("Could not find window with title: %s" % selected_title)
    else:
        print("Could not parse selected window: %s" % selected_window)
else:
    print("no selected_window")
