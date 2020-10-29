#!/bin/bash

### HP ZBOOK STUDIO SPECIFIC
sudo pacman -S xf86-input-libinput --noconfirm --needed
sudo echo "blacklist i2c_hid" > /etc/modprobe.d/i2c.conf
echo "----> Fixed touchpad!"

