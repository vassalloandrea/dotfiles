#!/bin/bash

source './utils.sh'

formulae=(
    "homebrew/services"
    "caskroom/cask"
    "mongodb/brew"
)

packages=(
    "git"
    "fish"
    "hub"
    "postgres"
    "mysql"
    "redis"
    "asdf"
    "gpg"
    "coreutils"
    "imagemagick"
    "heroku/brew/heroku"
    "the_silver_searcher"
    "fzf"
    "php"
    "mongodb-community"
    "k9s"
    "aws-iam-authenticator"
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
    "mattermost"
    "tunnelblick"
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

    brew update
    brew upgrade
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
        brew install "$command"
    done
}

function install_apps() {
    echo "\n"

    for app in "${apps[@]}"; do
        fancy_echo "Brew is going to install $app!"
        brew cask install "$app"
    done
}

function cleanup() {
    fancy_echo "Cleaning up old Homebrew formulae!"

    brew cleanup
}

install_brew
update_brew
install_formulae
install_packages
install_apps
cleanup
