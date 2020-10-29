#!/bin/bash
: '
Script to install display manager, desktop environment
and essential apps.
@author T. de Waard
'

set -e
mkdir -p ~/git
source $(dirname "$0")/funcs.sh

#### Connect to WiFi ####
nmcli
read -p "Connect to WiFi ? [y/n]: " wificon
if [[ "$wificon" == "y" ]]; then
    read -p "Device name (e.g. wlp2s0): " name
    read -p "Device SSID : " SSID
    read -p "Password for ${SSID} : " ssidpass
    nmcli device wifi connect "${SSID}" password "${ssidpass}"
    nmlci device set "${name}" autoconnect yes
fi

#### AUR helper ####
if [[  $(_isInstalled "yay") == 1 ]]; then
    git clone https://aur.archlinux.org/yay.git ~/git/yay
    cd ~/git/yay
    makepkg -si
else
    echo "Yay already installed!"
fi

#### GNOME & SWAY ####
read -p "Install DE/WM ? [y/n] : " deswitch
if [[ "$deswitch" == "y" ]]; then
    _installMany "gdm gnome gnome-extra gnome-control-center system-config-printer \
   	          gnome-remote-desktop" 
    read -p "Xorg (i3) or Wayland (sway) ? [i3/sway] : " de
    if [[ "$de" == "wayland" ]]; then
        _installMany "sway swaylock waybar wl-clipboard swayidle xorg-server-xwayland wofi mako"
    else
        _installMany "libinput i3-gaps-rounded-git polybar i3status i3lock-fancy-git rofi xclip picom dunst xorg-xinput"
    fi
    sudo systemctl enable gdm.service
fi

#### Audio ####
_installMany "pulseaudio pulseaudio-alsa pavucontrol alsa-utils \
              alsa-plugins alsa-lib alsa-firmware playerctl pamixer"

#### Utils ####
_installMany "network-manager-applet brightnessctl jq htop wget curl cmake"

#### Git config ####
read -p "Configure git ? [y/n]: " gitconf
if [[ "$gitconf" == "y" ]]; then
    read -p "Git user email (you@example.com) : " uemail
    read -p "Your name : " name
    git config --global user.email ""${uemail}""
    git config --global user.name ""${name}""
    git config --global core.editor "vim"
    git config --global pull.rebase "false"
fi
echo "Script was succesful!"
