export HOMEBREW_NO_AUTO_UPDATE=1
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export homebrew="/opt/homebrew/"

alias g='git '
alias ga='git add '
alias gA='git add -A'
alias gb='git branch '
alias gst='git status '
alias gc='git commit '
alias gp='git push '
alias gl='git log '
alias gd='git diff'
alias l='ls -lah'

eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -f '/Users/dmitriyivkov/Downloads/google-cloud-sdk/path.zsh.inc' ];
then . '/Users/dmitriyivkov/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/dmitriyivkov/Downloads/google-cloud-sdk/completion.zsh.inc' ];
then . '/Users/dmitriyivkov/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
