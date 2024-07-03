# makes dock appear/disapear instantaneously
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock


# git tracking
git add .config/nvim .config/htop/ .config/iterm2/ .config/starship.toml \
    .gitconfig .zshrc README.md .yabairc .tmux.conf .ideavimrc
git submodule add https://github.com/DIvkov575/nvim .config/nvim
git lfs track *.tar.gz
git add cct.tar.gz images.tar.gz stl.tar.gz miscellaneous.tar.gz 


# brew install
brew install zellij yabai nvim python3 nvm  starship zsh-autosuggestions docker git koekeishiya/formulae/yabai htop qemu folx skhd
brew install spotify  postman karabiner-elements yubico-yubikey-manager arc zoom 
brew install utm imhex 
<!-- brew install ubersicht -->


# curl
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

