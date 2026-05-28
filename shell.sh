#!/bin/bash

source ./utils.sh

function add_fish_to_shells() {
    # This is needed since fish isn't a standard shell
    if ! grep "$(which fish)" /etc/shells >/dev/null 2>&1; then
        fancy_echo "Adding fish to the legacy shells!"

        sudo bash -c "echo $(which fish) >> /etc/shells"
    fi
}

function update_shell() {
    # Check if the used shell is already set to fish
    if [[ $SHELL != *"fish"* ]]; then
        # Check if fish is installed
        if which fish >/dev/null 2>&1; then
            fancy_echo "Changing your shell to fish!"

            chsh -s $(which fish) $USER
        fi
    fi
}

function install_omf() {
    if [ ! -d "$HOME/.local/share/omf" ]; then
        fancy_echo "Installing Oh my Fish!"

        curl -L https://get.oh-my.fish | fish
    fi
}

function configure_mise() {
    fancy_echo "Configuring mise to use precompiled Ruby binaries (skip ruby-build)!"

    mise settings ruby.compile=false
}

function install_mise_language() {
    local name="$1"
    local version="$2"

    if ! mise ls "$name" 2>/dev/null | grep -Fq "$version"; then
        fancy_echo "Installing $name $version globally using mise!"

        mise use --global "$name@$version"
    fi
}

function install_fzf() {
    bash -c "$(brew --prefix)/opt/fzf/install --no-bash --no-zsh --key-bindings --completion --update-rc"
    fish -c fzf_key_bindings
}

function configure_gitignore_globally() {
    fancy_echo "Configuring git to ignore files globally!"

    git config --global core.excludesFile '~/.gitignore_global'
}

add_fish_to_shells
update_shell
install_omf
configure_mise
install_mise_language "ruby" "3.1.1"
install_mise_language "node" "lts"
install_mise_language "python" "3.13.2"
install_mise_language "pnpm" "latest"
install_mise_language "yarn" "1"
install_fzf
configure_gitignore_globally
