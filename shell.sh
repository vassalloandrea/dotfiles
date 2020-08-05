#!/bin/bash

source ./utils.sh

function add_fish_to_shells() {
    # This is needed since fish isn't a standard shell
    if ! grep "$(which fish)" /etc/shells > /dev/null 2>&1; then
        fancy_echo "Adding fish to the legacy shells!"

        run "echo $(which fish) >> /etc/shells"
    fi
}

function update_shell() {
    # Check if the used shell is already set to fish
    if [[ $SHELL != *"fish"* ]]; then
        # Check if fish is installed
        if which fish > /dev/null 2>&1; then
            fancy_echo "Changing your shell to fish!"

            run chsh -s $(which fish) $USER
        fi
    fi
}

function install_omf() {
    if [ ! -d "$HOME/.local/share/omf" ]; then
        fancy_echo "Installing Oh my Fish!"

        curl -L https://get.oh-my.fish | fish
    fi
}


add_fish_to_shells
update_shell
install_omf