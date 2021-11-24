#!/bin/bash

source './utils.sh'

apps=(
    "1510445899" # Meeter
    "1462114288" # Grammarly for Safari
    "595191960" # CopyClip
    "1402042596" # AdBlock
    "497799835" # Xcode
    "1176895641" # Spark
    "506189836" # Harvest
    "585829637" # Todoist
    "409201541" # Pages
    "1474276998" # HP smart
)

function install_mas() {
    if which mas &> /dev/null; then
        fancy_echo "Mas is already installed!"
    else
        fancy_echo "Mas is about to be installed!"
        sh -c "brew install mas"
    fi
}

function update_mas() {
    fancy_echo "Mas is about to be updated!"

    mas upgrade
}

function mas_login() {
    fancy_echo "You need to be logged in the app store!"

    mas signin --dialog andrea.vassallo.94@gmail.com
}

function install_apps() {
    echo "\n"

    for app in "${apps[@]}"; do
        fancy_echo "Mas is going to install $app!"
        mas install "$app"
    done
}

install_mas
update_mas
mas_login
install_apps
