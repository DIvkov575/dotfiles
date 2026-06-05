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

echo "==> Installing Xcode Command Line Tools (C/C++)"
xcode-select --install 2>/dev/null || true

echo "==> Installing Rust (via rustup)"
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "==> Installing language runtimes (via mise)"
eval "$(mise activate bash)"
mise install python@latest
mise install node@latest
mise use --global python@latest node@latest

echo "==> Installing Claude Code"
npm install -g @anthropic-ai/claude-code

echo "==> Applying macOS defaults"
bash "$DOTFILES/macos/defaults.sh"

echo "==> Done. Restart your terminal."
