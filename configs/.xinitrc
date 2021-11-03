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

xrandr --output DP-4 --mode 2560x1440 --rate 143.91 --dpi 90

# Xcursor environment variables
export XCURSOR_PATH=/usr/share/icons:${HOME}/.local/share/icons
export XCURSOR_THEME=Bibata-Modern-Classic
export XCURSOR_SIZE=24
# Wayland environment variables
#export MOZ_ENABLE_WAYLAND=1
#export KITTY_ENABLE_WAYLAND=1
#export QT_QPA_PLATFORM=wayland
# For tray visualisation
#export XDG_CURRENT_DESKTOP=Unity
# For Java-based apps on wayland
#export _JAVA_AWT_WM_NONREPARENTING=1

