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
    $HOME/.config/i3
    $HOME/.config/kitty
    $HOME/.config/neofetch
    $HOME/.config/picom
    $HOME/.config/polybar
    $HOME/.config/ranger
    $HOME/.config/redshift
    $HOME/.config/rofi
    $HOME/.config/Code/User/settings.json
    $HOME/.config/flameshot
    $HOME/.config/zathura
    $HOME/.conda/envs/py38/lib/python3.8/site-packages/matplotlib/mpl-data/matplotlibrc
    $HOME/.ipython/profile_default/startup/mystartup.py
    /etc/pacman.conf
    /etc/fstab
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
            # echo "[DIR]" "$f" "----->" "$DEST"
        elif [[ -f $f ]]; then
            cp -rf $f $DEST
            printf "[FILE]  %-${MAXLEN}s -----> %-50s\n" "$f" "$DEST"
            # echo "[FILE]" "$f" "----->" "$DEST"
        else
            echo $f does not exist!
        fi
    done
}

echo "Copying..."
copy $CONF

# Copy these files/folders to the repo
# echo "Copying ... "
# DEST=$(dirname "$0")/configs
# for f in $HOMECONF
# do
#     SOURCE=$HOME/$f
#     if [[ -d $SOURCE ]]; then
#         mkdir -p $DEST/$f
#         rsync -qa $SOURCE/ $DEST/$f/
#     else
#         cp -rf $SOURCE $DEST
#     fi
#     echo "$SOURCE" "------->" "$DEST"/"$f"
# done
# unset f
# unset SOURCE
# for f in $CONF
# do
#     SOURCE=$HOME/.config/$f
#     if [[ -d $SOURCE ]]; then
#         mkdir -p $DEST/$f
#         rsync -qa $SOURCE/ $DEST/$f/
#     else
#         # mkdir -p $DEST/$f
#         cp -rf $SOURCE $DEST
#     fi
#     echo "$SOURCE" "------->" "$DEST"/"$f"
# done
# unset f
# unset SOURCE
# for f in $SPECIAL
# do
#     SOURCE=$f
#     if [[ -d $SOURCE ]]; then
#         mkdir -p $DEST/$f
#         rsync -qa $SOURCE/ $DEST/$f/
#     else
#         cp -rf $SOURCE $DEST
#     fi
#     echo "$SOURCE" "------->" "$DEST"/$(basename $f)
# done
