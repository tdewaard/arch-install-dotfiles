#### ~/.zshenv ####

# Path additions
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/namd/NAMD_2.14_Linux-x86_64-multicore-CUDA:$PATH"
export PATH="/mnt/hdd_groot/OneDriveTUE/UNI/MASTER/AFSTUDEREN/adeno-python/pummatk/bin:$PATH"
export PATH="/mnt/hdd_groot/OneDriveTUE/UNI/MASTER/AFSTUDEREN/rosetta_bin_linux_2020.08.61146_bundle/main/source/bin:$PATH"

DE="gnome"
WM="i3"
TERM_DE="gnome-terminal"
TERM_WM="kitty"
EDITOR_DE="code"
EDITOR_WM="vim"
FM_WM="ranger"
FM_DE="nautilus"

# More environment variables
export BROWSER="firefox-nightly"
export BROWSER_ALT="firefox"
export EDITOR="$(if [[ $DESKTOP_SESSION == $WM ]]; then \
                     echo $EDITOR_WM; \
                 else \
                     echo $EDITOR_DE; \
                 fi)"
export TERMINAL="$(if [[ $DESKTOP_SESSION == $WM ]]; then \
                       echo $TERM_WM; \
                   else \
                       echo $TERM_DE; \
                   fi)"
export FM="$(if [[ $DESKTOP_SESSION == $WM ]]; then \
                 echo $FM_WM; \
             else \
                 echo $FM_DE; \
             fi)"
export VISUAL="$(if [[ $DESKTOP_SESSION == $WM ]]; then \
                 echo $EDITOR_WM; \
             else \
                 echo $EDITOR_DE; \
             fi)"

# Xcursor environment variables
# export XCURSOR_PATH=/usr/share/icons:${HOME}/.local/share/icons
# export XCURSOR_THEME=Bibata-Modern-Classic
# export XCURSOR_SIZE=24
# Wayland environment variables
#export MOZ_ENABLE_WAYLAND=1 
#export KITTY_ENABLE_WAYLAND=1
#export QT_QPA_PLATFORM=wayland
# For tray visualisation
#export XDG_CURRENT_DESKTOP=Unity
# For Java-based apps on wayland
#export _JAVA_AWT_WM_NONREPARENTING=1
# QT version Selection
# export QT_SELECT=4



