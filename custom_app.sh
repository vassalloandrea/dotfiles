#!/bin/bash

source './utils.sh'

function install_cx() {
    if [[ `uname -m` == 'arm64' ]]; then
        cp "$HOME/projects/personal/dotfiles/cx/m1" "/usr/local/bin/cx"
    else
        cp "$HOME/projects/personal/dotfiles/cx/intel" "/usr/local/bin/cx"
    fi
}

# CX is to cloud66 toolbet
install_cx
