export HOMEBREW_NO_AUTO_UPDATE=1

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.toolbox/bin:$PATH"

# Git
alias g='git '
alias ga='git add -A'
alias gb='git branch '
alias gs='git status '
alias gc='git commit '
alias gp='git push '
alias gl='git log '
alias gd='git diff'

# General
alias l='ls -lah'
alias cc='claude --dangerously-skip-permissions '
