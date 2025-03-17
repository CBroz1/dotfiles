# Notes
# list=(a b c); for t in ${list[@]}; do pip uninstall $t -y; done
# add kernel: ipython kernel install --name "local-venv" --user

# ------------------------------------ Path ------------------------------------
export PATH="/usr/local/bin:$PATH"
export PATH="/home/$USER/.local/bin/:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

# ---------------------------------- Secrets ----------------------------------
for key_file in ~/.config/*key; do
    [ -f "$key_file" ] && source "$key_file"
done

# ---------------------------------- Settings ----------------------------------
shopt -s checkwinsize # check window size
set -o vi # vi mode
set show-mode-in-prompt on
export EDITOR='nvim'
set syntax on
set bell-style visible
set filec

export HISTSIZE=100000
export HISTFILESIZE=100000
export BASH_SILENCE_DEPRECATION_WARNING=1

## make tab cycle through commands after listing
bind 'TAB:menu-complete'
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind '"\C-h": backward-kill-word'

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

complete -f ss # autocomplete for custom commands

# ----------------------------------- Prompt -----------------------------------
emojis=("🌀" "💀" "👽" "👾" "💜" "🦄" "🐙" "🌸" "🌄" "🎃" "🎆" "🔮" "🧿")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
HOST_FULL=$(hostname)
HOST_PART=${HOST_FULL:0:3}
export PS1="\[\e[0m\]$EMOJI \[\e[36m\]$HOST_PART\[\e[0m\] \[\e[38;5;140m\]\W\[\e[0m\] > "
export PS2=">"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# ---------------------------------- Aliases ----------------------------------

alias o="open ."
alias l="ls"
alias v="nvim"
alias ss='subl -a '
alias sm='/usr/bin/smerge'
alias python='python3'
alias jupysync='jupytext --to py notebooks/*ipynb; mv notebooks/*py notebooks/py_scripts; black notebooks/py_scripts'
alias profilev='nvim ~/.bash_profile'
alias loadprofile='source ~/.bash_profile'

alias bck="echo ' > /dev/null 2>&1 &' | pbcopy"
alias pbcopy='xclip -selection c -rmlastnl'
alias vdo="v ~/wrk/ucsf-notes.txt"
alias tmux="TERM=screen-256color-bce tmux"
alias tm='tmux has-session -t 0 2>/dev/null && TERM=screen-256color-bce tmux attach -t 0 || TERM=screen-256color-bce tmux'
alias spellcheckdir="cspell -c cspell.json ./**/*{py,md,yaml}"
alias pcc="pre-commit run --all-files"
alias mdlcheck="goruby; mdl -c .markdownlint.yaml ."

## Git
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git pull'
alias grom='git remote rename origin me'

## Environments
alias off="conda deactivate"
alias gospy="cd '${HOME}/wrk/spyglass'; conda activate spy"
alias goruby="source ${HOME}/.rvm/scripts/rvm # ruby version manager; rvm --default use 2.7 >/dev/null"

# --------------------------------- Functions ---------------------------------
alias funcs="declare -F | grep -vE \"^declare -f _|^declare -f nvm\""
piphas() { pip list | grep "$1"; }
cact() { conda activate "$1"; }
ipy() { ${HOME}/miniconda3/envs/"$1"/bin/python -m IPython --no-autoindent; }
spellcheck() { cspell check "$1" --color | less -r; }
jupythis() { jupytext --to py notebooks/*"$1"*ipynb ; mv notebooks/*py notebooks/py_scripts; }
vf() { v `fzf-tmux -1 -q $1`; }
loadenv() { export $(grep -v '^#' ${1:.env} | xargs); }
scpdown() { scp -i /home/user/.ssh/ucsf -P ${UCSF_SSH_PORT} cbroz@virga-05.cin.ucsf.edu:~/wrk/spyglass/"$1" ~/wrk/spyglass/"$1"; }
scpup() { scp -i /home/user/.ssh/ucsf -P ${UCSF_SSH_PORT} ~/wrk/spyglass/"$1" cbroz@virga-05.cin.ucsf.edu:~/wrk/spyglass/"$1"; }
killbyname() { killall -s 9 "$1"; }

# ------------------------ Docker ------------------------
if command -v docker &>/dev/null; then
  ## Docker
  alias dockerprune="\
    docker container prune -f;\
    docker image prune -af;\
    docker builder prune -f"
  alias dockermirr="dockerrm mirr; \
    docker volume prune -f; \
    docker run --cap-add=sys_nice \
    --name mirr -p 3309:3306 -e MYSQL_ROOT_PASSWORD=tutorial mysql:latest"
  dockerrm() {
      for container_id in "$@"; do
          docker stop "$container_id" >/dev/null 2>&1
          docker rm "$container_id" >/dev/null 2>&1
          echo "Container $container_id stopped and removed"
      done
  }
fi

# ----------------------------------- Conda -----------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/$USER/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$USER/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/$USER/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/$USER/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda config --set auto_activate_base false

# ------------------------------------ fzf ------------------------------------
# CTRL-R script to insert command from history into the command line/region
if command -v fzf &>/dev/null; then
  __fzf_history ()
  {
      builtin history -a;
      builtin history -c;
      builtin history -r;
      builtin typeset \
          READLINE_LINE_NEW="$(
              HISTTIMEFORMAT= builtin history |
              command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
              command sed '
                  /^ *[0-9]/ {
                      s/ *\([0-9]*\) .*/!\1/;
                      b end;
                  };
                  d;
                  : end
              '
          )";

          if
                  [[ -n $READLINE_LINE_NEW ]]
          then
                  builtin bind '"\er": redraw-current-line'
                  builtin bind '"\e^": magic-space'
                  READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                  READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
          else
                  builtin bind '"\er":'
                  builtin bind '"\e^":'
          fi
  }
  builtin set -o histexpand;
  builtin bind -x '"\C-x1": __fzf_history';
  builtin bind '"\C-r": "\C-x1\e^\er"'
  alias ff='fzf'
fi

# ------------------------------------ NVM ------------------------------------
if command -v nvm &>/dev/null; then
  source ~/.nvm/nvm.sh
  export NVM_DIR="$HOME/.nvm"
fi

# ----------------------------------- Tools -----------------------------------
# zoxide, thefuck, fd, sd, exa, ncdu
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
  alias g='z'
fi
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)" || true
fi
if command -v eza &>/dev/null; then
  alias ll='eza -l --icons --git -a'
  alias lt='eza --tree --level=2 --long --icons --git'
fi
if command -v ncdu &>/dev/null; then
  alias duu='ncdu --color dark'
fi
if command -v batcat &>/dev/null; then
  alias bat='batcat'
fi
