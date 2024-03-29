#!/bin/bash

source ./utils.sh

function add_fish_to_shells() {
    # This is needed since fish isn't a standard shell
    if ! grep "$(which fish)" /etc/shells > /dev/null 2>&1; then
        fancy_echo "Adding fish to the legacy shells!"

        echo $(which fish) >> /etc/shells
    fi
}

function update_shell() {
    # Check if the used shell is already set to fish
    if [[ $SHELL != *"fish"* ]]; then
        # Check if fish is installed
        if which fish > /dev/null 2>&1; then
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

function install_asdf_plugins() {
    fancy_echo "Installing asdf version manager plugins (Ruby, NodeJS and Python)"

    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    asdf plugin-add python https://github.com/tuvistavie/asdf-python.git
}

function install_asdf_language() {
    local name="$1"
    local version="$2"

    if ! asdf list "$name" | grep -Fq "$version"; then
        fancy_echo "Installing $name $version globally using asdf!"

        asdf install "$name" "$version"
        asdf global "$name" "$version"
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
install_asdf_plugins
install_asdf_language "ruby" "2.7.1"
install_asdf_language "nodejs" "14.7.0"
install_asdf_language "python" "3.8.5"
install_fzf
configure_gitignore_globally
