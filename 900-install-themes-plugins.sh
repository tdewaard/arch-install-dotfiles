#!/bin/sh

set -e
source $(dirname "$0")/funcs.sh

read -p "Install custom ZSH themes [y/n] ? : " spaceship
if [[ "$spaceship" == "y" ]]; then
    _gitInstall "romkatv" "powerlevel10k" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    echo "[Set ZSH_THEME=<theme-name> in ~/.zshrc]"
fi

read -p "Install Kitty themes [y/n] ? : " kittytheme
if [[ "$kittytheme" == "y" ]]; then
    _gitInstall "dexpota" "kitty-themes"
fi

read -p "Install ZSH plugins [y/n] ? : " zshsyn
if [[ "$zshsyn" == "y" ]]; then
    _gitInstall "zsh-users" "zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    echo "Add zsh-autosuggestions to oh-my-zsh plugins"
    _gitInstall "zsh-users" "zsh-syntax-highlighting" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    echo "Add zsh-syntax-highlighting as last oh-my-zsh plugin"
fi

read -p "Install custom grub theme [y/n] ? : " grubtheme
if [[ "$grubtheme" == "y" ]]; then
    _gitInstall "Xyr0s1gn" "grub2-solarized-dark"
    mkdir -p /boot/grub/themes
    sudo cp -r ~/git/grub2-solarized-dark /boot/grub/themes
    _gitInstall "vinceliuice" "grub2-themes"
    echo "[Use grub-customizer to select the theme.]"
fi

read -p "Install GTK/Gnome/Icon/Cursor themes [y/n] ? : " themes
if [[ "$themes" == "y" ]]; then
    _install gtk-engine-murrine gtk-engines bibata-cursor-theme
    _gitInstall "dracula" "gnome-terminal"
    _gitInstall "dracula" "gtk"
    _gitInstall "vinceliuice" "Vimix-cursors"
    _gitInstall "vinceliuice" "vimix-gtk-themes"
    _gitInstall "vinceliuice" "vimix-icon-theme"
fi

read -p "Install spicetify (Spotify) themes [y/n] ? : " spice
if [[ "$spice" == "y" ]]; then
    _install "spicetify-cli"
    _gitInstall "morpheusthewhite" "spicetify-themes" "${HOME}/.config/spicetify/Themes"
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
fi
