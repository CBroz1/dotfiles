#!/bin/sh

# history
HISTFILE=~/.zsh_history
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# Prompt Random emoji in cmd prompt
emojis=("🌀" "💀" "👽" "👾" "💜" "🦄" "🐙" "🌸" "🌄" "🎃" "🎆" "🔮" "🧿")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
export PS1="$EMOJI \[$(tput setaf 140)\]\W\[\033[m\] > "
export PS2=">"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Path 
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/texlive/2023/bin/PLATFORM:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

export EDITOR="nvim"
# export TERMINAL="kitty"
export BROWSER="firefox"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# export PATH=$HOME/.cargo/bin:$PATH
# export PATH=$HOME/.local/share/go/bin:$PATH
# export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.fnm:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
# export XDG_CURRENT_DESKTOP="Wayland"
# export PATH="$PATH:./node_modules/.bin"
# eval "$(fnm env)"
# eval "`pip completion --zsh`"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# zoxide, thefuck, OpenAI
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"
source ~/.config/openai_api_key


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("/$HOME/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda config --set auto_activate_base false

