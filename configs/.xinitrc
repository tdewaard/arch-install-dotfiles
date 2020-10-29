#!/bin/sh
#
# ~/.xinitrc
# 

if [[ -d etc/X11/xinit/xinitrc.d ]]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrandr --output DP-4 --mode 2560x1440 --rate 143.91
