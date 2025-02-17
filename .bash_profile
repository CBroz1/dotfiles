# --------------------- Path ---------------------
export PATH="/usr/local/bin:$PATH"
export PATH="/home/$USER/.local/bin/:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
source ~/.nvm/nvm.sh

# --------------------- Settings ---------------------
# shopt -s autocd # if give path only, assume cd, need bash upgrade
shopt -s checkwinsize # check window size
set -o vi # vi mode
export EDITOR='nvim'
set show-mode-in-prompt on

# Random emoji in cmd prompt
emojis=("🌀" "💀" "👽" "👾" "💜" "🦄" "🐙" "🌸" "🌄" "🎃" "🎆" "🔮" "🧿")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
HOST_FULL=$(hostname)
HOST_PART=${HOST_FULL:0:3}
# PS1 needs brackets around to prevent overwrite
# export PS1="\[$EMOJI \[$(tput setaf 140)\]\W \033[m\]> \]"

# export PS1="$EMOJI \[$(tput setaf 140)\]\W\[\033[m\] > "
export PS1="$EMOJI \033[36m\$HOST_PART\033[m \[$(tput setaf 140)\]\W\[\033[m\] > "
export PS2=">"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export HISTFILESIZE=100000
export HISTSIZE=100000
export BASH_SILENCE_DEPRECATION_WARNING=1
## make tab cycle through commands after listing
bind 'TAB:menu-complete'
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
# bind '"\e[A": history-search-backward' # up is auto-completes
# bind '"\e[B": history-search-forward'
bind '"\C-h": backward-kill-word'
set syntax on
set bell-style visible
set filec

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# --------------------- Aliases ---------------------
## General
alias o="open ."
alias l="ls"
alias ss='subl -a '
alias python='python3'
alias v="nvim"
alias sm='/usr/bin/smerge'
alias jupysync='jupytext --to py notebooks/*ipynb; mv notebooks/*py notebooks/py_scripts; black notebooks/py_scripts'
alias pbcopy='xclip -selection c -rmlastnl'
alias bck="echo ' > /dev/null 2>&1 &' | pbcopy"
alias profiles='ss ~/.bash_profile'
alias profilev='nvim ~/.bash_profile'
alias profilec='code ~/.bash_profile'
alias loadprofile='source ~/.bash_profile'
alias tmux="TERM=screen-256color-bce tmux"
alias sp="spotifyd;spt"
alias spellcheckdir="cspell -c cspell.json ./**/*{py,md,yaml}"
alias pcc="pre-commit run --all-files"
alias mdlcheck="goruby; mdl -c .markdownlint.yaml ."
alias killvlc="killall -s 9 vlc"
alias killfort="killall -s 9 forticlient" # or  fctsched, fortitray, fortitraylaunch
alias todo="clear; awk 'BEGIN {found=0} found==0 && NF>0 {print; next} {found=1; exit}' ~/wrk/ucsf-notes.txt"
alias vdo="v ~/wrk/ucsf-notes.txt"
## Git
alias gb="vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]'"
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git pull'
alias grom='git remote rename origin me'
## Docker
# alias dockerls='docker ps -a --format "{{.ID}} {{.Status}} {{.Names}}" | awk "{print \$1, \$2, substr(\$3, 1, 50)}"'
# alias dockerls='docker ps -a --format "{{.ID}} {{.Status}} {{.Names}}" | awk "{print \$1, \$2, substr(\$3, 1, 80)}"'
alias dockerprune="\
  docker container prune -f;\
  docker image prune -af;\
  docker builder prune -f"
alias dockerremove="docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)"
alias dockerup="docker compose --env-file ./docker/.env -f ./docker/docker-compose*.yaml up --build --force-recreate --detach"
alias dockerdn="docker compose -f ./docker/docker-compose-test.yaml down --volumes"
alias dockermirr="docker run --name mirr -p 3309:3306 -e MYSQL_ROOT_PASSWORD=tutorial datajoint/mysql:8.0"
## Environments
alias off="conda deactivate"
alias tmp="off; conda activate tmp" # Temp
alias pytmp="/Users/$USER/miniconda3/envs/tmp/bin/python -m IPython --no-autoindent"
alias gospy="cd '${HOME}/wrk/spyglass'; conda activate spy"
# Ruby
alias goruby="source ${HOME}/.rvm/scripts/rvm # ruby version manager; rvm --default use 2.7 >/dev/null"
## Google drive for linux
alias syncdrives="rsync -hraP --ignore-existing --delete --exclude '*.Trash-1000' /media/$USER/all/ /media/$USER/bck/"
# --------------------- Functions ---------------------
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
dockerrm() {
    for container_id in "$@"; do
        docker stop "$container_id" >/dev/null 2>&1
        docker rm "$container_id" >/dev/null 2>&1
        echo "Container $container_id stopped and removed"
    done
}

# Notes
# list=(a b c); for t in ${list[@]}; do pip uninstall $t -y; done
# add kernel: ipython kernel install --name "local-venv" --user
# . /Users/$USER/miniconda3/etc/profile.d/conda.sh

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

## autocomplete for custom commands
complete -f ss

## fzf command history
# Another CTRL-R script to insert the selected command from history into the command line/region
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

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# zoxide, thefuck, fd, sd, exa, ncdu
eval "$(zoxide init bash)" || true
eval "$(thefuck --alias)" || true
alias ll='eza -l --icons --git -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias duu='ncdu --color dark'
alias g='z'
alias ff='fzf'
alias bat='batcat'
