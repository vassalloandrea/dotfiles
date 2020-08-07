#!/bin/bash

formulae=(
    "homebrew/services"
    "caskroom/cask"
)

packages=(
    "git"
    "fish"
    "hub"
    "postgres"
    "mysql"
    "redis"
    "asdf"
)

apps=(
    "iterm2"
    "spectacle"
    "google-chrome"
    "firefox"
    "telegram"
    "skype"
    "slack"
    "postman"
    "spotify"
    "harvest"
    "grammarly"
    "gifox"
    "visual-studio-code"
    "whatsapp"
    "notion"
)

function install_brew() {
    if which brew &> /dev/null; then
        fancy_echo "Homebrew is already installed!"
    else
        fancy_echo "Homebrew is about to be installed!"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
}

function update_brew() {
    fancy_echo "Homebrew is about to be updated!"

    run brew update
    run brew upgrade
}

function install_formulae() {
    echo "\n"

    for formula in "${formulae[@]}"; do
        fancy_echo "Installing brew formulae $formula!"
    done
}

function install_packages() {
    echo "\n"

    for command in "${packages[@]}"; do
        fancy_echo "Brew is going to install $command!"
        run brew install "$command"
    done
}

function install_apps() {
    echo "\n"

    for app in "${apps[@]}"; do
        fancy_echo "Brew is going to install $app!"
        run brew cask install "$app"
    done
}

function cleanup() {
    fancy_echo "Cleaning up old Homebrew formulae!"

    run brew cleanup
}

install_brew
update_brew
install_formulae
install_packages
install_apps
cleanup
