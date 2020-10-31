#!/bin/bash
: '
Install script for "non-essential" personal apps
@author T. de Waard
'

set -e
mkdir -p ~/git
source $(dirname "$0")/funcs.sh

#### Terminal ####
_install "kitty"

#### Browser ####
if [ ! -f /usr/bin/firefox-nightly ]; then
    echo "Installing firefox-nightly..."
    mkdir -p ~/ffnightly
    cd ~/ffnightly
    wget "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US" -O firefox-nightly.tar.bz2
    tar xvf firefox-nightly.tar.bz2
    mv firefox firefox-nightly
    sudo ln -s ~/ffnightly/firefox-nightly/firefox /usr/bin/firefox-nightly
	mkdir -p ~/.local/share/applications
	touch ~/.local/share/applications/nightly.desktop
	tee ~/.local/share/applications/nightly.desktop <<EOF
[Desktop Entry]
Version=1.0
Name=Nightly
Comment=Browse the World Wide Web
Exec=/usr/bin/firefox-nightly %u
Terminal=false
Type=Application
Icon=/home/${whoami}/ffnightly/firefox-nightly/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
Actions=Default;Mozilla;ProfileManager;

[Desktop Action Default]
Name=Default Profile
Exec=/usr/bin/firefox-nightly –no-remote -P minefield-default

[Desktop Action Mozilla]
Name=Mozilla Profile
Exec=/usr/bin/firefox-nightly –no-remote -P minefield-mozilla

[Desktop Action ProfileManager]
Name=Profile Manager
Exec=/usr/bin/firefox-nightly –no-remote –profile-manager
EOF
    echo "Successfully installed firefox-nightly!"
else
    echo "Firefox-nightly already installed."
fi
_install "firefox"

#### Spotify ####
_installMany "yasm ffmpeg-compat-57 zenity libcurl-gnutls libcanberra appmenu-gtk-module spotify"

#### Vim Plugin Manager ####
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing Vim Plug plugin manager..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Successfully installed Vim Plug plugin manager..."
else
    echo "Vim Plug already installed."
fi

#### ZSH ####
_installMany "zsh zsh-autosuggestions"
read -p "Install oh-my-zsh? [y/n]: " choice
if [[ "$choice" == "y" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""
    chsh -s $(which zsh) $(whoami)
    sudo chsh -s $(which zsh) root
    touch ~/.zshenv ~/.zprofile
    rm ~/.bashrc
else
    echo "Skipped oh-my-zsh install."
fi

#### Fonts ####
read -p "Install all nerd fonts? [y/n]: " choice
if [[ "$choice" == "y" ]]; then
    _gitInstall "ryanoasis" "nerd-fonts"
else
    echo "Skipped nerd fonts install."
fi

#### RANGER ####
_installMany "imagemagick ranger python-pillow atool elinks ffmpegthumbnailer highlight libcaca lynx mediainfo odt2txt perl-image-exiftool poppler python-chardet"
if [[ $(_isInstalled "i3-gaps") ]]; then
    _install "feh"
else
    _install "imv"
fi

#### VIM ####
_install "gvim"

### Mail ####
_installMany "thunderbird birdtray"

#### Syncthing #####
_installMany "syncthing"
read -p "Configure syncthing start on boot ? [y/n] : " syncstart
if [[ "$syncstart" == "y" ]]; then
    _gitInstall "syncthing" "syncthing"
    sudo cp ~/git/syncthing/etc/linux-systemd/system/syncthing@.service /etc/systemd/system
    systemctl enable syncthing@$(whoami).service
    systemctl start syncthing@$(whoami).service
fi

#### RSync ####
_install "rsync"

#### LaTeX related ####
read -p "Install LaTeX related packages? [y/n]: " latex
if [[ "$latex" == "y" ]]; then
    _installMany "zathura zathura-pdf-mupdf texlive-most texlive-lang biber"
fi

#### PDFPC ####
_install "pdfpc"

#### MATLAB dependencies ####
_installMany "libselinux libxss libcanberra-gstreamer libcanberra-pulse"

#### VSCode ####
_install "visual-studio-code-bin"

#### Python IDE & Anaconda ####
_install "pycharm-professional"
if [[ ! -f /usr/bin/conda ]]; then
    mkdir -p ~/git/anaconda
    git clone https://aur.archlinux.org/anaconda.git ~/git/anaconda
    cd ~/git/anaconda
    makepkg -si
    sudo ln -sf /opt/anaconda/bin/conda /usr/bin/conda
else
    echo "Anaconda already installed."
fi

#### OpenJDK ####
_install "jdk-openjdk"

#### Graphics stuff ####
_installMany "blender gimp inkscape"

#### Random ####
_install "neofetch"

#### HWinfo ####
_install "hwinfo"

### Screenshots ####
if [[ $(_isInstalled "i3-gaps") ]]; then
    _install "flameshot"
else
    _installMany "grim slurp grimshot"
fi

#### Libreoffice ####
_install "libreoffice-fresh"

#### GUI for hdmi outputs ####
if [[ $(_isInstalled "i3-gaps") ]]; then
    _install "arandr"
else
    _install "wdisplays"
fi

#### Overlay display bar ####
if [[ ! $(_isInstalled "i3-gaps") ]]; then
    _install "wob"
fi

#### Blue light filter ####
if [[ $(_isInstalled "i3-gaps") ]]; then
    _install "redshift"
    read -p "Configure redshift systemd unit [y/n] ? : " redsh
    if [[ "$redsh" == "y" ]]; then
        sudo touch "/etc/systemd/system/redshift@$(whoami).service"
        sudo tee "/etc/systemd/system/redshift@$(whoami).service" <<EOF
[Unit]
Description=Redshift adjusts the color temperature of your screen according to your surroundings
Documentation=http://jonls.dk/redshift/
After=graphical.target

[Service]
User=%i
Type=simple
Environment=DISPLAY=:1
ExecStart=/usr/bin/redshift -c /home/$(whoami)/.config/redshift/redshift.conf
TimeoutStopSec=5

[Install]
WantedBy=graphical.target
EOF
    systemctl --user enable redshift
    systemctl --user start redshift
    fi
else
    _install "gammastep"
fi

#### Some extra fonts ####
_installMany "ttf-ubuntu-font-family ttf-font-awesome ttf-cmu-bright ttf-cmu-concrete ttf-cmu-sans-serif ttf-cmu-serif"

