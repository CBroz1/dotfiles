if [ -f /bin/brew ]; then
  eval "$(/bin/brew shellenv)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -------------------- Secrets --------------------
source ~/.config/*key

# -------------------- Profile --------------------
# Source .bash_profile if it exists
if [ -f "$HOME/.bash_profile" ]; then
    source "$HOME/.bash_profile"
fi

