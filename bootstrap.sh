#!/bin/bash

source ./utils.sh

options=(
    -avh --no-perms
    --exclude ".git"
    --exclude ".gitignore"
    --exclude "bootstrap.sh"
    --exclude "brew.sh"
    --exclude "macos.sh"
    --exclude "shell.sh"
    --exclude "utils.sh"
)

# Retrieve all the gitignore file and directories that
# should be excluded from the rsync command
while read line; do
  options+=(--exclude "$line")
done < .gitignore

# Copy all the files and directories to the user home
# except for the ones included in the options array
fancy_echo "Copying the dotfiles to the home directory!"
rsync "${options[@]}" . ~

# Install brew with packages and applications
sh ./brew.sh
# Apply MacOS changes
sh ./macos.sh
# Apply shell changes installing fish
sh ./shell.sh

source ~/.bash_profile;
