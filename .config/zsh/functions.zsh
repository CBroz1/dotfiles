piphas() { pip list | grep "$1"; }
act() { conda activate "$1"; }
ipy() { /Users/cb/miniforge3/envs/"$1"/bin/python -m IPython --no-autoindent; }
spellcheck() { cspell check "$1" --color | less -r; }
jupythis() { jupytext --to py notebooks/*"$1"*ipynb ; mv notebooks/*py notebooks/py_scripts; }
sf() { ss `fzf-tmux -1 -q $1`; }
loadenv() { export $(grep -v '^#' ${1:.env} | xargs); }
git_branch_info () {
   echo -ne "\033[36m$(vcprompt -M ' moded' -U ' untrkd' -A ' stgd' -f '[%b%a] ')\033[m"
}
