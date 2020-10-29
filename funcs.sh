#!/bin/bash
: '
Some functions to be used in my scripts.
@author T. de Waard
'

_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ] ; then
        echo 0
        return
    fi;
    echo 1
    return
}

_install() {
    package="$1";

    # If the package IS installed:
    if [[ $(_isInstalled "${package}") == 0 ]]; then
        return
    fi

    # If the package is NOT installed:
    if [[ $(_isInstalled "${package}") == 1 ]]; then
        sudo pacman -S "${package}" --noconfirm --needed || yay -S "${package}"
    fi
}

_installMany() {
    NotInstalled=()
    ToInstall=()

    for pkg in $1; do
        # If the package IS installed, skip it.
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            NotInstalled+=("${pkg}");
            continue;
        else
            toInstall+=("${pkg}")
            continue;
        fi;
    done;
    yay -S "${toInstall[@]}"
    echo "Packages install skipped:" 
    echo "${NotInstalled[@]}"
    if [[ "${ToInstall[@]}" != "" ]]; then
        echo "Packages install performed:" 
        echo "${ToInstall[@]}"
    fi
}

_gitInstall() {
    name="$1"
    repo="$2"
    if [[ "$3" != "" ]]; then
        dir="$3"
    else
        dir="$HOME/git/${repo}"
    fi
    mkdir -p "${dir}"
    git clone --depth=1 https://github.com/"${name}/${repo}".git "${dir}" || git -C "${dir}" pull 
    if [[ -f "${dir}"/install.sh ]]; then
        read -p "Git repo ${name}/${repo} has install.sh, run it [y/n] ? " install
        if [[ $install == "y" ]]; then
            cmd="${dir}/install.sh"
            if sh "${cmd}" || sudo sh "${cmd}" ; then 
                echo "Git repo (${name}/${repo}) installed."
            else
                echo "Git repo (${name}/${repo}) not installed."
            fi
        else
            echo "Git repo (${name}/${repo}) is in ${dir}, no installation script was run."
        fi
    else
        echo "Git repo (${name}/${repo}) is in ${dir}"
    fi
}
