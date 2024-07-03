export HOMEBREW_NO_AUTO_UPDATE=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

alias gst='git '
alias gst='git status '
alias gc='git commit '
alias gp='git push '
alias gl='git log '
alias l='ls -lah'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -f '/Users/dmitriyivkov/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dmitriyivkov/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/dmitriyivkov/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dmitriyivkov/google-cloud-sdk/completion.zsh.inc'; fi
