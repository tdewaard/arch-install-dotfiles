#!/bin/sh


case "$1" in
    lock)
        sh ~/.config/sway/scripts/myswaylock.sh
        ;;
    logout)
        swaymsg exit
        ;;
    suspend)
        systemctl suspend
        sh ~/.config/sway/scripts/myswaylock.sh
        ;;
    hibernate)
        systemctl hibernate
        sh ~/.config/sway/scripts/myswaylock.sh
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
