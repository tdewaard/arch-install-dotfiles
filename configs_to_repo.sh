#!/bin/sh


HOMECONF="
    .zshrc
    .zshenv
    .bash_profile
    .bashrc
    .gitconfig
    .xinitrc
    .xprofile
    .vimrc
"
CONF="
    autostart
    dunst
    gtk-3.0
    gtk-4.0
    i3
    kitty
    neofetch
    picom
    polybar
    ranger
    redshift
    rofi
    Code/User/settings.json
"
SPECIAL="
    /etc/pacman.conf
    /etc/fstab
"

# Copy these files/folders to the repo
echo "Copying ... "
DEST=$(pwd)/configs
for f in $HOMECONF
do
    SOURCE=$HOME/$f
    if [[ -d $SOURCE ]]; then
        mkdir -p $DEST/$f
        rsync -qa $SOURCE/ $DEST/$f/
    else
        cp -rf $SOURCE $DEST
    fi
    echo "$SOURCE" "------->" "$DEST"/"$f"
done
unset f
unset SOURCE
for f in $CONF
do
    SOURCE=$HOME/.config/$f
    if [[ -d $SOURCE ]]; then
        mkdir -p $DEST/$f
        rsync -qa $SOURCE/ $DEST/$f/
    else
        mkdir -p $DEST/$f
        cp -rf $SOURCE $DEST/$f
    fi
    echo "$SOURCE" "------->" "$DEST"/"$f"
done
unset f
unset SOURCE
for f in $SPECIAL
do
    SOURCE=$f
    if [[ -d $SOURCE ]]; then
        mkdir -p $DEST/$f
        rsync -qa $SOURCE/ $DEST/$f/
    else
        cp -rf $SOURCE $DEST
    fi
    echo "$SOURCE" "------->" "$DEST"/"$f"
done
