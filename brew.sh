#!/bin/bash

source './utils.sh'

# CLI tools, version managers, build/media utilities
packages=(
    # Shell + version manager
    "fish"
    "mise"

    # Git / repo workflow
    "gh"
    "lazygit"

    # Shell utilities
    "fzf"
    "ripgrep"
    "the_silver_searcher"
    "coreutils"
    "gawk"

    # Editors
    "neovim"

    # Formatters
    "shfmt"

    # Media
    "imagemagick@6"
    "ffmpeg"
)

# GUI applications via Homebrew Cask
apps=(
    # Terminal + editor
    "iterm2"
    "visual-studio-code"

    # Browser + password manager
    "brave-browser"
    "bitwarden"

    # Communication / mail / calendar
    "slack"
    "telegram"
    "readdle-spark"
    "fantastical"

    # Productivity
    "linear-linear"
    "ticktick"
    "obsidian"
    "notion"
    "raycast"

    # System utilities
    "appcleaner"
    "betterdisplay"
    "hiddenbar"
    "imageoptim"
    "gifox"

    # Dev / API / containers
    "claude"
    "claude-code"
    "postman"
    "docker"

    # VPN / networking
    "tailscale"
    "mullvadvpn"
)

# Fonts (tap is auto-handled by Homebrew for font-* casks)
fonts=(
    "font-jetbrains-mono-nerd-font"
)

# brew link --force targets (e.g. for keg-only formulae)
links=(
    "imagemagick@6"
)

function install_brew() {
    if which brew &>/dev/null; then
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

function install_fonts() {
    echo "\n"

    for font in "${fonts[@]}"; do
        fancy_echo "Brew is going to install $font!"
        brew install --cask "$font"
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
install_packages
install_apps
install_fonts
link_packages
cleanup
