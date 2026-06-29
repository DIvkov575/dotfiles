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

echo "==> Configuring git"
read -p "Git name: " GIT_NAME
read -p "Git email: " GIT_EMAIL
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ecdsa.pub
git config --global commit.gpgsign true
echo "$GIT_EMAIL $(cat ~/.ssh/id_ecdsa.pub)" > ~/.ssh/allowed_signers
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers

echo "==> Linking dotfiles"
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/nvim" ~/.config/nvim
mkdir -p ~/.claude ~/.claude/commands
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json
ln -sfn "$DOTFILES/claude/agents" ~/.claude/agents
# Per-file (not whole-dir) so the memory tool can install /memorize + /recall
# into the same real dir without writing inside the dotfiles repo.
for c in "$DOTFILES"/claude/commands/*.md; do
  [ -e "$c" ] && ln -sf "$c" ~/.claude/commands/"$(basename "$c")"
done
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
ln -sf "$DOTFILES/ghostty/config" ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty
mkdir -p ~/.config/karabiner ~/.config/skhd ~/.config/yabai
ln -sf "$DOTFILES/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
ln -sf "$DOTFILES/skhd/skhdrc" ~/.config/skhd/skhdrc
ln -sf "$DOTFILES/yabai/yabairc" ~/.config/yabai/yabairc
chmod +x ~/.config/yabai/yabairc

echo "==> Linking Firefox user.js"
FF_PROFILE=$(find ~/Library/Application\ Support/Firefox/Profiles -maxdepth 1 -name "*.default-release" 2>/dev/null | head -1)
if [ -n "$FF_PROFILE" ]; then
  ln -sf "$DOTFILES/firefox/user.js" "$FF_PROFILE/user.js"
fi

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

echo "==> Installing persistent memory system (tool + private memories)"
# Public tooling and private memory content live in separate repos under
# ~/workplace. The tool resolves the memories via MEM_HOME (default below).
mkdir -p ~/workplace
MEM_HOME="$HOME/workplace/mymemories"
TOOL_DIR="$HOME/workplace/mymemories-tool"
if [ ! -d "$MEM_HOME/.git" ]; then
  git clone git@github.com:DIvkov575/mymemories.git "$MEM_HOME" \
    || echo "  (skip: could not clone private mymemories — clone it manually, then re-run this block)"
fi
if [ ! -d "$TOOL_DIR/.git" ]; then
  git clone https://github.com/DIvkov575/mymemories-tool.git "$TOOL_DIR"
fi
if [ -d "$TOOL_DIR/.git" ]; then
  ( cd "$TOOL_DIR"
    ./install.sh         # symlink partitions into ~/.claude/projects
    ./install-hook.sh    # register SessionStart hook + install /memorize, /recall
    ./setup.sh           # create .venv + install fastembed
    [ -d "$MEM_HOME" ] && python3 embed.py update )   # build embedding index
fi

echo "==> Applying macOS defaults"
bash "$DOTFILES/macos/defaults.sh"

echo "==> Done. Restart your terminal."
