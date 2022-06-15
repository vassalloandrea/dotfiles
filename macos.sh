#!/bin/bash

persistent_applications=(
    "/Applications/Postman.app"
    "/Applications/Safari.app"
    "/Applications/Google Chrome.app"
    "/System/Applications/Calendar.app"
    "/Applications/Harvest.app"
    "/Applications/iTerm.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/WhatsApp.app"
    "/Applications/Telegram.app"
    "/Applications/Slack.app"
    "/Applications/Loom.app"
    "/Applications/Notion.app"
    "/Applications/Spark.app"
    "/Applications/ImageOptim.app"
    "/System/Applications/System Preferences.app"
    "/Applications/Spotify.app"
    "/Applications/1Password 7.app"
    "/Applications/Xcode.app"
    "/Applications/NordVPN.app"
    "/Applications/Brother iPrint&Scan.app"
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

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36
# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# Do not show recent application
defaults write com.apple.dock show-recents -bool false

# Add persistent applications
for app in "${persistent_applications[@]}"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

########### Trackpad and mouse ###########

# Enable natural scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

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
