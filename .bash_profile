
# --------------------- Path ---------------------
export PATH="/usr/local/bin:$PATH"
export PATH="/home/cb/.local/bin/:$PATH"
export PATH="/usr/local/texlive/2023/bin/PLATFORM:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

# -------------------- Toggl ---------------------
export TOGGL_PROJECT='law'

# --------------------- Settings ---------------------
# shopt -s autocd # if give path only, assume cd, need bash upgrade
shopt -s checkwinsize # check window size

# Random emoji in cmd prompt
emojis=("🌀" "💀" "👽" "👾" "💜" "🦄" "🐙" "🌸" "🌄" "🎃" "🎆" "🔮" "🧿")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
# PS1 needs brackets around to prevent overwrite
# export PS1="\[$EMOJI \[$(tput setaf 140)\]\W \033[m\]> \]" 
# -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]
git_branch_info () {
   echo -ne "\033[36m$(vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a] ')\033[m"
}
export PS1="$EMOJI \[$(tput setaf 140)\]\W\[\033[m\] > "
# git_branch_info () {
#    echo -ne "\033[36m$(vcprompt -f '[%b] ')"
# }
export PS2=">"
# export PROMPT_COMMAND=git_branch_info # This was slow
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export HISTFILESIZE=100000
export HISTSIZE=100000
export BASH_SILENCE_DEPRECATION_WARNING=1
# export COMPOSE_DOCKER_CLI_BUILD=0
## make tab cycle through commands after listing
bind 'TAB:menu-complete'
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
# bind '"\e[A": history-search-backward' # up is auto-completes
bind '"\e[B": history-search-forward'
bind '"\C-h": backward-kill-word'
set syntax on
set bell-style visible
set filec

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# complete -C /usr/local/bin/mc mc

# --------------------- OSX ----------------------- 
# defaults write com.apple.screencapture disable-shadow -bool true # turn off app shadows
# export HDF5_DIR=/opt/homebrew/opt/hdf5
# eval "$(/opt/homebrew/bin/brew shellenv)"
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
# fi
## pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
## Adobe prevent startup. To reverse, unload->load. Also SysPref->Extensions
# launchctl unload -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist > /dev/null 2>&1
# launchctl unload -w /Library/LaunchAgents/com.adobe.ccxprocess.plist > /dev/null 2>&1
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist > /dev/null 2>&1
# alias sm='/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge'
# alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox -P"
## cd shortcuts
# export ref="/Users/cb/Google Drive/My Drive/ref/"
# export dev="/Users/cb/Documents/dev/"
# alias gogo="cd '/Users/cb/Google Drive/My Drive/'"
# alias goref="cd '/Users/cb/Google Drive/My Drive/ref/'"
# alias godev="cd '/Users/cb/Documents/dev/'"

# --------------------- Aliases ---------------------
## General
alias o="open ."
alias l="ls"
alias ll='ls -aGg --color'
alias ss='subl -a '
alias python='python3'
alias v="nvim"
alias sm='/usr/bin/smerge'
alias pie="pip list -e | grep 'workf\|elem\|adamacs\|dataj'"
alias jupysync='jupytext --to py notebooks/0*ipynb; mv notebooks/*py notebooks/py_scripts'
alias gitexec='git config core.fileMode false'
alias bck="echo ' > /dev/null 2>&1 &' | pbcopy"
alias profile='ss ~/.bash_profile'
alias profiles='ss ~/.bash_profile'
alias profilen='nvim ~/.bash_profile'
alias profilev='nvim ~/.bash_profile'
alias profilec='code ~/.bash_profile'
alias loadprofile='source ~/.bash_profile'
alias matlab="/Applications/MATLAB_R2022a.app/bin/matlab -nojvm -nodesktop"
alias tmux="TERM=screen-256color-bce tmux"
alias sp="spotifyd;spt"
alias spellcheckdir="cspell -c cspell.json ./**/*{py,md,yaml}"
alias precommitcheck="pre-commit run --all-files"
alias mdlcheck="goruby; mdl -c .markdownlint.yaml ."
alias killvlc="killall -s 9 vlc"
alias killfort="killall -s 9 forticlient" # or  fctsched, fortitray, fortitraylaunch
## Git
alias gb="vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]'"
# alias gb='git_branch_info'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git pull'
alias grom='git remote rename origin me'
## Docker
alias dockerprune="docker image prune -f; docker volume prune -f; docker builder prune -fa" 
alias dockerremove="docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)"
alias dockerup="docker compose --env-file ./docker/.env -f ./docker/docker-compose*.yaml up --build --force-recreate --detach"
alias dockerdn="docker compose -f ./docker/docker-compose-test.yaml down --volumes"
## Environments
alias off="conda deactivate"
alias tmp="off; conda activate tmp" # Temp
alias pytmp="/Users/cb/miniforge3/envs/tmp/bin/python -m IPython --no-autoindent"
alias doa="conda activate doa" # DofA
alias godoa="cd '${HOME}/fun/TheGame'; conda activate doa"
alias gospy="cd '${HOME}/wrk/spyglass'; conda activate spy"
alias pydoa="${HOME}/miniforge3/envs/doa/bin/python -m IPython --no-autoindent -i temp.py"
alias pympw="${HOME}/miniforge3/envs/mpw/bin/python -m IPython --no-autoindent -i temp.py"
# Ruby
alias goruby="source ${HOME}/.rvm/scripts/rvm # ruby version manager; rvm --default use 2.7 >/dev/null"
## Google drive for linux
alias mountgoog="rclone -v --vfs-cache-mode writes mount goog: ~/goog/"
alias mountmpw="sudo mount -t cifs -o credentials=/home/cb/.config/mpw_credentials //192.168.75.6/Network /media/cb/mpw/"
alias syncdrives="rsync -hraP --ignore-existing --delete --exclude '*.Trash-1000' /media/cb/all/ /media/cb/bck/"
# --------------------- Functions ---------------------
piphas() { pip list | grep "$1"; }
act() { conda activate "$1"; }
ipy() { /Users/cb/miniforge3/envs/"$1"/bin/python -m IPython --no-autoindent; }
spellcheck() { cspell check "$1" --color | less -r; }
jupythis() { jupytext --to py notebooks/*"$1"*ipynb ; mv notebooks/*py notebooks/py_scripts; }
sf() { ss `fzf-tmux -1 -q $1`; }
loadenv() { export $(grep -v '^#' ${1:.env} | xargs); }

# Notes
# list=(a b c); for t in ${list[@]}; do pip uninstall $t -y; done
# alias fetchall="for f in $(ls -d ele*); do cd ./$f; git fetch --all; sm .; cd ..; done"

# add kernel: ipython kernel install --name "local-venv" --user
# . /Users/cb/miniforge3/etc/profile.d/conda.sh

# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cb/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cb/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cb/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cb/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda config --set auto_activate_base false

## run redshift if not already running
# if [ ! $(pgrep -x redshift-gtk) ]; then
#     redshift-gtk &
# fi

## autocomplete for custom commands
complete -f ss

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## zoxide
eval "$(zoxide init bash)"
## thefuck
eval "$(thefuck --alias)"

# clear
echo "warpd: A-M-x, A-M-c.; jupythis; gb"

