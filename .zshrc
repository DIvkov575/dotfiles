export HOMEBREW_NO_AUTO_UPDATE=1
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

alias gst='git status '
alias gc='git commit '
alias gp='git push '
alias gl='git log '

alias l='ls -lah'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dmitriyivkov/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dmitriyivkov/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dmitriyivkov/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dmitriyivkov/google-cloud-sdk/completion.zsh.inc'; fi
