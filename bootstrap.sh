#!/bin/bash

source ./utils.sh

options=(
    -avh --no-perms
    --exclude ".git"
    --exclude ".gitignore"
    --exclude "utils.sh"
    --exclude "bootstrap.sh"
    --exclude "brew.sh"
    --exclude "macos.sh"
)

# Retrieve all the gitignore file and directories that
# should be excluded from the rsync command
while read line; do
  options+=(--exclude "$line")
done < .gitignore

# Copy all the files and directories to the user home
# except for the ones included in the options array
fancy_echo "Copying the dotfiles to the home directory!"
clean_run rsync "${options[@]}" . ~

source ~/.bash_profile;
