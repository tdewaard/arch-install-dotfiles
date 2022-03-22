#!/bin/sh


CONF="
    $HOME/.zshrc
    $HOME/.zshenv
    $HOME/.bash_profile
    $HOME/.bashrc
    $HOME/.gitconfig
    $HOME/.xinitrc
    $HOME/.xprofile
    $HOME/.vimrc
    $HOME/.config/mako
    $HOME/.config/sway
    $HOME/.config/wob
    $HOME/.config/autostart
    $HOME/.config/dunst
    $HOME/.config/gtk-3.0
    $HOME/.config/gtk-4.0
    $HOME/.config/htop
    $HOME/.config/i3
    $HOME/.config/kitty
    $HOME/.config/neofetch
    $HOME/.config/picom
    $HOME/.config/polybar
    $HOME/.config/waybar
    $HOME/.config/ranger
    $HOME/.config/redshift
    $HOME/.config/rofi
    $HOME/.config/Code/User/settings.json
    $HOME/.config/flameshot
    $HOME/.config/zathura
    $HOME/.config/matplotlib
    $HOME/.ipython/profile_default/startup/mystartup.py
    /etc/pacman.conf
    /etc/fstab
    /etc/systemd/journald.conf
    /etc/X11/xorg.conf.d/00-keyboard.conf
    /etc/X11/xorg.conf.d/10-mouse.conf
"
copy() {
    CONFS=$@
    DESTDIR=$(dirname "$0")/configs
    MAXLEN=0
    for f in $CONFS
    do
        LEN=${#f}
        if [[ $LEN > $MAXLEN ]]; then
            MAXLEN=$LEN
        fi
    done
    for f in $CONFS
    do
        DEST=$DESTDIR/$(basename $f)
        if [[ -d $f ]]; then
            mkdir -p $DEST
            rsync -qa $f/ $DEST/
            printf "[DIR]   %-${MAXLEN}s -----> %-50s\n" "$f" "$DEST"
        elif [[ -f $f ]]; then
            cp -rf $f $DEST
            printf "[FILE]  %-${MAXLEN}s -----> %-50s\n" "$f" "$DEST"
        else
            echo $f does not exist!
        fi
    done
}

echo "Copying..."
copy $CONF
