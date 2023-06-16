# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# source custom
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# plugins
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"

# keybinds
bindkey '^ ' autosuggest-accept
bindkey '<End>' autosuggest-accept
bindkey '^r' fzf-history-widget
bindkey -v '<Del>' backward-delete-char
bindkey '<Del>' backward-delete-char

export PATH="$HOME/.local/bin":$PATH
export ZDOTDIR=$HOME/.config/zsh

# Load and initialise completion system
autoload -Uz compinit
compinit

stty sane
