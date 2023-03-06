
# --------------------- Path ---------------------
## Orig version is saved in .bash_profile.pysave
## Setting PATH for Python 3.9
export PATH="/usr/local/bin:$PATH"
# export PATH="$HOME/.poetry/bin:$PATH"
# export PATH="/opt/homebrew/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export HDF5_DIR=/opt/homebrew/opt/hdf5
eval "$(/opt/homebrew/bin/brew shellenv)"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# --------------------- Settings ---------------------
# shopt -s autocd # if give path only, assume cd, need bash upgrade
shopt -s checkwinsize # check window size

# Random emoji in cmd prompt
emojis=("💀" "👽" "👾" "💜" "🦄" "🐙" "🌸" "🌄" "🎃" "🎆" "🔮" "🧿")
EMOJI=${emojis[$RANDOM % ${#emojis[@]} ]}
# PS1 needs brackets around to prevent overwrite
export PS1="\[$EMOJI \[$(tput setaf 140)\]\W \033[m\]> \]" 
# -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]
git_branch_info () {
   echo -ne "\033[36m$(vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a] ')\033[m"
}
# export PS1="$EMOJI \[$(tput setaf 140)\]\W \033[m>"
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
export COMPOSE_DOCKER_CLI_BUILD=0
## make tab cycle through commands after listing
bind '"\t":menu-complete'
bind 'TAB:menu-complete'
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"
bind '"\e[A": history-search-backward' # up is auto-completes
bind '"\e[B": history-search-forward'
set syntax on
set bell-style visible
set filec

complete -C /usr/local/bin/mc mc

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## Adobe prevent startup. To reverse, unload->load. Also SysPref->Extensions
launchctl unload -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist > /dev/null 2>&1
launchctl unload -w /Library/LaunchAgents/com.adobe.ccxprocess.plist > /dev/null 2>&1
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist > /dev/null 2>&1

## OS 
defaults write com.apple.screencapture disable-shadow -bool true # turn off app shadows


# --------------------- Aliases ---------------------
## General
alias o="open ."
alias l="ls"
alias ll='ls -aGg'
alias ss='subl -a '
alias python='python3'
alias sm='/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge'
alias pie="pip list -e | grep 'workf\|elem\|adamacs\|dataj'"
alias jupysync='jupytext --to py notebooks/0*ipynb; mv notebooks/*py notebooks/py_scripts'
alias gitexec='git config core.fileMode false'
alias bck="echo ' > /dev/null 2>&1 &' | pbcopy"
alias profile='ss ~/.bash_profile'
alias profiles='ss ~/.bash_profile'
alias profilec='code ~/.bash_profile'
alias loadprofile='source ~/.bash_profile'
alias matlab="/Applications/MATLAB_R2022a.app/bin/matlab -nojvm -nodesktop"
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox -P"
alias sp="spotifyd;spt"
alias spellcheckdir="cspell -c cspell.json ./**/*{py,md,yaml}"
alias precommitcheck="pre-commit run --all-files"
alias mdlcheck="goruby; mdl -c .markdownlint.yaml ."
# alias loadenv="export $(grep -v '^#' .env | xargs)"
## Git
alias gb="vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]'"
# alias gb='git_branch_info'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git pull'
## Docker
alias dockerprune="docker image prune -f; docker volume prune -f; docker builder prune -fa" 
alias dockerremove="docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)"
alias dockerup="docker compose --env-file ./docker/.env -f ./docker/docker-compose*.yaml up --build --force-recreate --detach"
alias dockerdn="docker compose -f ./docker/docker-compose-test.yaml down --volumes"
## cd shortcuts
export ref="/Users/cb/Google Drive/My Drive/ref/"
export dev="/Users/cb/Documents/dev/"
alias gogo="cd '/Users/cb/Google Drive/My Drive/'"
alias goref="cd '/Users/cb/Google Drive/My Drive/ref/'"
alias godev="cd '/Users/cb/Documents/dev/'"
## Environments
alias off="conda deactivate"
alias tmp="off; conda activate tmp" # Temp
alias pytmp="/Users/cb/miniforge3/envs/tmp/bin/python -m IPython --no-autoindent"
alias ele="conda activate ele" # Elements
alias goele="off; cd '/Users/cb/Documents/dev/'; ele"
alias pyele="/Users/cb/miniforge3/envs/ele/bin/python -m IPython --no-autoindent"
alias bon="conda activate bon" # Bonn
alias gobon="off; cd '/Users/cb/Documents/proj/bonn/adamacs'; bon"
alias pybon="/Users/cb/miniforge3/envs/bon/bin/python -m IPython --no-autoindent"
alias doa="conda activate doa" # DofA
alias godoa="cd '/Users/cb/Documents/temp/creative/TheGame'; conda activate doa"
alias pydoa="/Users/cb/miniforge3/envs/doa/bin/python -m IPython --no-autoindent -i temp.py"
alias pse="conda activate pse" # Pose
alias gopse="off; cd '/Users/cb/Documents/proj/pose/PosePipeline'; pse"
alias pypse="/Users/cb/miniforge3/envs/pse/bin/python -m IPython --no-autoindent"
alias dlc="conda activate dlc" # DLC
alias godlc="off; cd '/Users/cb/Documents/dev/'; dlc"
alias pydlc="/Users/cb/miniforge3/envs/dlc/bin/python -m IPython --no-autoindent"
alias cai="conda activate caimg"
alias pycai="/Users/cb/miniforge3/envs/caimg/bin/python -m IPython --no-autoindent"
## Ruby
alias goruby="source ${HOME}/.rvm/scripts/rvm # ruby version manager; rvm --default use 2.7 >/dev/null"
## Princeton
alias apps='salt Pni; ssh cb1848@scotty.pni.princeton.edu'
alias spock='salt Pni; ssh -XY cb1848@scotty.pni.princeton.edu'
alias scotty='salt Pni; ssh -XY cb1848@scotty.pni.princeton.edu'

# --------------------- Functions ---------------------
piphas() { pip list | grep "$1"; }
act() { conda activate "$1"; }
ipy() { /Users/cb/miniforge3/envs/"$1"/bin/python -m IPython --no-autoindent; }
cdd() { cd ./*"$1"*; }
spellcheck() { cspell check "$1" --color | less -r; }
jupythis() { jupytext --to py notebooks/*"$1"*ipynb ; mv notebooks/*py notebooks/py_scripts; }

# Notes
# list=(a b c); for t in ${list[@]}; do pip uninstall $t -y; done
# alias fetchall="for f in $(ls -d ele*); do cd ./$f; git fetch --all; sm .; cd ..; done"

# add kernel: ipython kernel install --name "local-venv" --user
. /Users/cb/miniforge3/etc/profile.d/conda.sh

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true

# clear
echo "warpd: A-M-x, A-M-c. hjkl er; jupythis; gb"
