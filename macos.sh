#!/bin/bash

persistent_applications=(
    "/Applications/Brave Browser.app"
    "/Applications/Fantastical.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Spark Desktop.app"
    "/Applications/Telegram.app"
    "$HOME/Applications/iTerm.app"
    "/Applications/Slack.app"
    "/Applications/Linear.app"
    "/Applications/TickTick.app"
    "/Applications/Obsidian.app"
    "/Applications/Bitwarden.app"
)

########### UI ###########

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

########### Finder ###########

# Allow quitting via ⌘ + Q
defaults write com.apple.finder QuitMenuItem -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

killall Finder

########### Dock ###########

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 54
# Enable magnification and set the magnified size
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 69
# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# Do not show recent applications in the Dock
defaults write com.apple.dock show-recents -bool false
# Minimize windows into the application icon
defaults write com.apple.dock minimize-to-application -bool true

# Add persistent applications
for app in "${persistent_applications[@]}"; do
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

########### Top corners ###########

# Lock screen when top left hot corner
defaults write com.apple.dock wvous-tl-corner -int 13
defaults write com.apple.dock wvous-tl-modifier -int 0

########### ITerm2 ###########

# Load preferences from a custom directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Specify the custom directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.iterm2"

killall Dock
