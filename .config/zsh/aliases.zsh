#!/bin/sh

# General
alias o="open ."
alias l="ls"
alias pbcopy='xclip -selection c -rmlastnl'
alias bck="echo ' > /dev/null 2>&1 &' | pbcopy"

# zsh
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory, cpu
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# edit profile
alias profile='ss ~/.zshrc ~/.config/zsh/aliases.zsh'
alias profiles='ss ~/.zshrc ~/.config/zsh/aliases.zsh'
alias profilen='nvim ~/.zshrc ~/.config/zsh/aliases.zsh'
alias profilev='nvim ~/.zshrc ~/.config/zsh/aliases.zsh'
alias profilec='code ~/.zshrc ~/.config/zsh/aliases.zsh'
alias loadprofile='source ~/.zshrc'

# Git
alias g='lazygit'
alias m="git checkout master"
alias s="git checkout stable"
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git pull'
alias grom='git remote rename origin me'
alias gb="vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a%m%u]'"
alias gitexec='git config core.fileMode false'

# Python
alias python='python3'
alias pie="pip list -e | grep 'workf\|elem\|adamacs\|dataj'"
alias jupysync='jupytext --to py notebooks/0*ipynb; mv notebooks/*py notebooks/py_scripts'

# Conda Environments
alias off="conda deactivate"
alias tmp="off; conda activate tmp" # Temp
alias pytmp="/Users/cb/miniforge3/envs/tmp/bin/python -m IPython --no-autoindent"
alias doa="conda activate doa" # DofA
alias godoa="cd '${HOME}/fun/TheGame'; conda activate doa"
alias gospy="cd '${HOME}/wrk/spyglass'; conda activate spy"
alias pydoa="${HOME}/miniforge3/envs/doa/bin/python -m IPython --no-autoindent -i temp.py"
alias pympw="${HOME}/miniforge3/envs/mpw/bin/python -m IPython --no-autoindent -i temp.py"

# nvim
alias v="nvim"
alias nvimrc='nvim ~/.config/nvim/'

# sublime
alias ss='subl -a '
alias sm='/usr/bin/smerge'

# bat
if command -v bat &> /dev/null; then
  alias bat="bat --theme \"Dracula\""
  alias cat="bat --theme \"Dracula\""
fi

# Exa, ndcu, other shiny toys
alias j='z' # zoxide
alias ll='exa -l --icons --git -a'
alias lt='exa --tree --level=2 --long --icons --git'
alias duu='ncdu --color dark'
alias chat='chatgpt'

# Docker
alias dockerprune="docker image prune -f; docker volume prune -f; docker builder prune -fa" 
alias dockerremove="docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)"
alias dockerup="docker compose --env-file ./docker/.env -f ./docker/docker-compose*.yaml up --build --force-recreate --detach"
alias dockerdn="docker compose -f ./docker/docker-compose-test.yaml down --volumes"

## Google drive for linux
alias mountgoog="rclone -v --vfs-cache-mode writes mount goog: ~/goog/"
alias mountmpw="sudo mount -t cifs -o credentials=/home/cb/.config/mpw_credentials //192.168.75.6/Network /media/cb/mpw/"
alias syncdrives="rsync -hraP --ignore-existing --delete --exclude '*.Trash-1000' /media/cb/all/ /media/cb/bck/"

# Ruby
# alias goruby="source ${HOME}/.rvm/scripts/rvm # ruby version manager; rvm --default use 2.7 >/dev/null"

# Other
alias tmux="TERM=screen-256color-bce tmux"
alias sp="spotifyd;spt"
alias spellcheckdir="cspell -c cspell.json ./**/*{py,md,yaml}"
alias precommitcheck="pre-commit run --all-files"
alias mdlcheck="goruby; mdl -c .markdownlint.yaml ."
alias killvlc="killall -s 9 vlc"
alias killfort="killall -s 9 forticlient" # or  fctsched, fortitray, fortitraylaunch

if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
