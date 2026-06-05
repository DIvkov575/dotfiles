#!/bin/bash
# macOS preferences

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock tilesize -int 16
defaults write com.apple.dock show-recents -bool false

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Reduce animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/$USER/Downloads/"
defaults write com.apple.finder FXPreferredGroupBy -string "Date Created"

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Disable default hotkeys (Spotlight, Mission Control, input sources)
for id in 15 16 17 18 19 20 21 22 23 164; do
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add $id '{ enabled = 0; }'
done

# Mission Control: Ctrl+j/k/l/; for spaces 1-4
# 118=Space1, 119=Space2, 120=Space3, 121=Space4; 262144=Ctrl modifier
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 '{ enabled = 1; value = { parameters = (106, 38, 262144); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 '{ enabled = 1; value = { parameters = (107, 40, 262144); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 '{ enabled = 1; value = { parameters = (108, 37, 262144); type = standard; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 121 '{ enabled = 1; value = { parameters = (59, 41, 262144); type = standard; }; }'

# Apply
killall Dock
killall Finder
