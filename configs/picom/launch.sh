#!/bin/sh

killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

picom -bcGf --config ~/.config/picom/picom.conf --experimental-backends --no-vsync --refresh-rate 144 --log-level "WARN"
