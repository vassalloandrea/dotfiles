#!/bin/bash

source './utils.sh'

formulae=(
    "homebrew/services"
    "homebrew/cask"
    "mongodb/brew"
)

packages=(
    "mas"
    "adoptopenjdk/openjdk/adoptopenjdk8" # needed to react native
    "gawk" # needed for asdf nodejs
    "gmp" # needed for asdf php
    "libsodium" # needed for asdf php
    "bison" # needed for asdf php
    "re2c" # needed for asdf php
    "libgd" # needed for asdf php
    "libiconv" # needed for asdf php
    "oniguruma" # needed for asdf php
    "libzip" # needed for asdf php
    "git"
    "fish"
    "hub"
    "postgres"
    "mysql"
    "redis"
    "asdf"
    "gpg"
    "coreutils"
    "imagemagick@6"
    "heroku/brew/heroku"
    "the_silver_searcher"
    "fzf"
    "mongodb-community"
    "aws-iam-authenticator"
    "watchman"
    "ngrok"
)

apps=(
    "docker"
    "cleanmymac"
    "iterm2"
    "spectacle"
    "google-chrome"
    "firefox"
    "loom"
    "discord"
    "telegram"
    "skype"
    "slack"
    "postman"
    "spotify"
    "gifox"
    "visual-studio-code"
    "android-studio"
    "whatsapp"
    "1password"
    "imageoptim"
    "notion"
    "remotion"
)

links=(
    "imagemagick@6"
)

function install_brew() {
    if which brew &> /dev/null; then
        fancy_echo "Homebrew is already installed!"
    else
        fancy_echo "Homebrew is about to be installed!"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
	    brew tap "$formula"
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
        brew install --cask "$app"
    done
}

function link_packages() {
    echo "\n"

    for link in "${links[@]}"; do
        fancy_echo "Brew is going to link $link!"
        brew link "$link" --force
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
link_packages
cleanup
