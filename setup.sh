#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew (if needed)"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing packages"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> Linking dotfiles"
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/nvim" ~/.config/nvim
mkdir -p ~/.claude
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json
mkdir -p ~/.config/karabiner ~/.config/skhd ~/.config/yabai
ln -sf "$DOTFILES/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
ln -sf "$DOTFILES/skhd/skhdrc" ~/.config/skhd/skhdrc
ln -sf "$DOTFILES/yabai/yabairc" ~/.config/yabai/yabairc
chmod +x ~/.config/yabai/yabairc

echo "==> Applying macOS defaults"
bash "$DOTFILES/macos/defaults.sh"

echo "==> Done. Restart your terminal."
