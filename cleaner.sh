#!/bin/bash

# Script for cleaning up your arch install
# @author Tristan de Waard

# set -e
source $(dirname "$0")/funcs.sh

# Remove orphaned pkg
if [[ $(pacman -Qtdq) != "" ]]; then
    sudo pacman -Rns $(pacman -Qtdq)
else
    echo "No orphaned packages removed."
fi

# Delete pacman cache
_install pacman-contrib
paccache -r

# Deleting yay cache
yay -Sc --noconfirm --needed

# Delete some caches in home
sudo rm -rf ~/.cache/*
sudo rm -rf ~/.config/Code/Cache/*
sudo rm -rf ~/.config/Code/CachedData/*
sudo rm -rf ~/.config/Microsoft/Microsoft\ Teams/Cache/*

# Detect duplicate dirs/files/symlinks etc.
_install rmlint
read -p "Run rmlint ? [y/n]" rmlint
if [[ "${rmlint}" == "y" ]]; then
	sudo rmlint ~
	echo "Run sh -c ./rmlint.sh for actual cleanup!"
fi

# Visualise large dirs/files
_install "ncdu"
read -p "Run ncdu ? [y/n]" ncdu
if [[ "${ncdu}" == "y" ]]; then
    ncdu ~
fi

# Making sure journalctl logs do not exceed 50 MB
sudo journalctl --vacuum-size=50M
echo "Set journalctl logs to 50MB permanently by setting
      SystemMaxUse=50M in /etc/systemd/journald.conf"
