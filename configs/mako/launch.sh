#!/usr/bin/env sh
killall -q mako

while pgrep -u $UID -x mako >/dev/null; do sleep 1; done

mako -c ~/.config/mako/config.ini > ~/.mako_debug
