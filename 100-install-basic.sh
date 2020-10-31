#!/bin/bash
: '
Install script for basic, essential packages
To be used before user creation inside (mounted) root environment.
@author T. de Waard
'

set -e

echo "Install script for a basic Arch Linux install."
echo "Abort the procedure with Ctrl+C at any time."
read -n 1 -s -r -p "Press any key to continue"
echo ""

#### WiFi and Clock ####
read -p "Use WiFi? [y/n] ?" WIFI
if [[ "${WIFI}" == "y" ]]; then
    echo "Connecting to WiFi with iwctl..."
    iwctl device list
    read -p "Enter device name (e.g. wlan0) : " device
    read -p "Enter SSID : " SSID
    read -p "Enter passphrase : " passphrase
    iwctl --passphrase "${passphrase}" station "${device}" connect "${SSID}"
fi
read -p "Update system clock?" clock
if [[ "${clock}" == "y"  ]]; then
	echo "Updating system clock..."
	read -p "Select time-zone (e.g. Europe/Amsterdam) : " timezone
	timedatectl set-timezone "${timezone}"
fi


#### Reflector ####
read -p "Update pacman mirrorlist [y/n] ?" mirror
if [[ "${mirror}" == "y" ]]; then
	pacman -S reflector
	echo "Updating mirrorlist..."
	reflector --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	echo "Done"
	echo "Creating hook for automatic mirrorlist upgrade..."
	mkdir -p /etc/pacman.d/hooks
	touch /etc/pacman.d/hooks/mirrorupgrade.hook
	tee /etc/pacman.d/hooks/mirrorupgrade.hook <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = pacman-mirrorlist

[Action]
Description = Updating pacman-mirrorlist with reflector and removing pacnew...
When = PostTransaction
Depends = reflector
Exec = /bin/sh -c "--latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist; rm -f /etc/pacman.d/mirrorlist.pacnew"
EOF
	echo "Done"
fi

#### The basics #####
read -p "Install basic kernel-related packages ?" basic
if [[ "${basic}" == "y" ]]; then
	echo "Installing kernel packages..."
	pacman -S linux linux-lts linux-headers linux-lts-headers linux-firmware
	echo "Installing base-devel and openSSH..."
	pacman -S base-devel openssh
	systemctl enable sshd
fi
read -p "Install NVidia proprietary drivers ? [y/n] : " nvidia
if [[ "${nvidia}" == "y" ]]; then
    pacman -S nvidia nvidia-lts
    echo "Creating hook for correct nvidia driver upgrades..."
    touch /etc/pacman.d/hooks/nvidia.hook
    tee /etc/pacman.d/hooks/nvidia.hook <<EOF
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF
    touch /etc/pacman.d/hooks/nvidia-lts.hook
    tee /etc/pacman.d/hooks/nvidia-lts.hook <<EOF
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-lts
Target=linux-lts

[Action]
Description=Update Nvidia-LTS module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux-lts) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF
    echo "Done"
fi
read -p "Install networking packages ? [y/n] : " network
if [[ "${network}" == "y" ]]; then
	echo "Installing basic networking packages..."
	pacman -S networkmanager wpa_supplicant wireless_tools nano
	systemctl enable NetworkManager
	mkinitcpio -p linux
	mkinitcpio -p linux-lts
fi
read -p "Set locale / hostname ? [y/n] : " setloc
if [[ "$setloc" == "y" ]]; then
    read -p "Enter locale string (e.g. en_GB.UTF-8): " LOC
    sed -i "/#${LOC}/s/^#*\s*//g" /etc/locale.gen
    locale-gen
    echo "LANG=${LOC}" > /etc/locale.conf
    read -p "Device host name: " HOSTNAME
    echo "${HOSTNAME}" > /etc/hostname
    tee /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${HOSTNAME}.localdomain ${HOSTNAME}
EOF
fi
read -p "Set username and passwords ? [y/n]: " setpass
if [[ "$setpass" == "y" ]]; then
    echo "Setting root password..."
    passwd
    echo "Adding a user..."
    read -p "Choose username: " USERNAME
    useradd -m -g users -G wheel "${USERNAME}"
    passwd "${USERNAME}"
    echo "Allowing users in wheel group to access sudo... "
    echo "Uncomment '%wheel ALL=(ALL) ALL'"
    read -n 1 -s -r -p "Press any key to continue"
    EDITOR=vim visudo
fi
pacman -S sudo man grub efibootmgr dosfstools os-prober mtools grub-customizer
read -p "Set up grub bootloader ? [y/n]: " setgrub
if [[ "$setgrub" == "y" ]]; then
   # mkdir -p /boot/EFI
   # fdisk -l
   # read -p "EFI partition = /dev/" efipart
   # mount "/dev/${efipart}" /boot/EFI
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    mkdir -p /boot/grub/locale
    read -p "Give grub locale (e.g. en) " grubloc
    cp "/usr/share/locale/${grubloc}@quot/LC_MESSAGES/grub.mo" "/boot/grub/locale/${grubloc}.mo"
    grub-mkconfig -o /boot/grub/grub.cfg
    echo ".efi file is located at: /EFI/grub_uefi/grubx64.efi"
fi
echo "Is fstab file correct ?"
echo "================================================"
cat /etc/fstab
echo "================================================"
read -n 1 -s -r -p "Press any key to continue"
echo "Installing intel cpu / gpu packages..."
pacman -S intel-ucode mesa
echo "Exit chroot with 'exit', then 'umount -a' and 'poweroff'"
