
# git tracking
git add .config/nvim .gitconfig .zshrc README.md .yabairc .ideavimrc
git submodule add https://github.com/DIvkov575/nvim .config/nvim

git lfs track *.tar.gz
git add cct.tar.gz images.tar.gz stl.tar.gz miscellaneous.tar.gz 


# brew install
brew install  koekeishiya/formulae/yabai skhd 
brew install git nvim zsh-autosuggestions docker spotify arc zoom google-cloud-sdk macs-fan-control karabiner-elements uv nvm telegram ubico-yubikey-manager


# curl
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


# configuration 
---
# Arc
Extensions: keepa, bitwarden, block site, super video speed controller, ublock

# MacOS
# Settings
Keyboard shortcuts
keyboard/services/text - search manpage ... -- stops cmd-shift-a from working in jetbrains

# makes dock appear/disapear instantaneously
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
