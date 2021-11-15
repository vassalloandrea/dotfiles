#!/bin/bash

source './utils.sh'

accounts=(
    "personal"
    "nebulab"
)

function install_heroku_accounts() {
    if heroku accounts &> /dev/null; then
        fancy_echo "Heroku accounts is already installed!"
    else
        fancy_echo "Heroku accounts is about to be installed!"
        sh -c "heroku plugins:install heroku-accounts"
    fi
}

function add_accounts() {
    fancy_echo "Add the personal account!"
    sh -c "heroku accounts:add personal"

    fancy_echo "Add the nebulab account!"
    sh -c "heroku accounts:add nebulab"
}

install_heroku_accounts
add_accounts
