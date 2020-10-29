#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

# Launch waybar 
waybar --config ~/.config/waybar/config-material.json --style ~/.config/waybar/style-material.css --log-level off
