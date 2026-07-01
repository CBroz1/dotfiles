#! /bin/bash
# AUTHOR: Chris Brozdowski
# DATE: 2025-02-14
#
# DESCRIPTION: This script is used to configure a new Pop!_OS installation.
# Run with one or more flags to select which sections to apply:
#   --apt    apt/npm/docker installs (run as sudo)
#   --pip    python pip installs (run as user)
#   --links  link dotfiles to home directory by relative path
#   --gnome  gnome desktop settings
#   --all    all of the above

usage() {
    grep '^#   --' "$0" | sed 's/^# //'
    echo ""
    echo "Usage: $0 [--apt] [--pip] [--links] [--gnome] [--all]"
}

# apt/npm/docker installs
do_apt() {
    if ! sudo -n true 2>/dev/null; then
        echo "Please rerun as sudo to install packages"
        return
    fi
    # Apt installs
    sudo add-apt-repository ppa:libreoffice/ppa -y > /dev/null # libreoffice
    sudo add-apt-repository ppa:deadsnakes/ppa -y > /dev/null # python versions
    sudo apt update -y > /dev/null
    # grep/sed below allow for comments in the file
    sudo apt install $(grep -v '^\s*#' ./install_scripts/apt_installs_pop.txt \
      | sed 's/\s*#.*//' | tr '\n' ' ') -y > /dev/null
    sudo npm install saltthepass > /dev/null

    # npm
    while IFS= read -r package || [[ -n "$package" ]]; do
        if [[ ! -z "$package" ]]; then
            npm install -g "$package" > /dev/null
        fi
    done < ./install_scripts/npm_installs_pop.txt

    # DOCKER
    sudo groupadd docker > /dev/null 2>&1
    sudo usermod -aG docker $USER
    sudo chmod 777 /var/run/docker.sock
}

# Python installs
do_pip() {
    if sudo -n true 2>/dev/null; then
        echo "Please rerun as user (not sudo) to install pip packages"
    elif command -v pip &> /dev/null; then
        pip install --upgrade pip > /dev/null 2>&1
        pip install -r ./install_scripts/py_installs_pop.txt > /dev/null 2>&1
    else
        echo "Skipping python installs: pip not found"
    fi
}

# link dotfiles
do_links() {
    cd ~/dotfiles || { echo "Error: Could not access ~/dotfiles"; exit 1; }
    exclude=("install_scripts*" "*key" "code*" "READ*" "*config.sh")
    git ls-files --exclude-standard | while read file; do # ignore .gitignore files
        for pattern in "${exclude[@]}"; do
            if [[ "$file" == $pattern ]]; then
                continue 2  # Skips to the next file in `while` loop
            fi
        done
        target="$HOME/$file"  # Place symlink in home directory
        mkdir -p "$(dirname "$target")"  # Ensure parent directories exist
        # -e misses broken symlinks, so also test -L; together they make a
        # re-run replace any existing target (file, dir, or dangling link)
        # instead of failing `ln` with "File exists".
        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "REPL $file → $target"
        else
            echo "ADD  $PWD/$file → $target"
        fi
        # -f overwrites; -n avoids descending into an existing symlinked dir.
        ln -sfn "$PWD/$file" "$target"
    done
}

# gnome desktop settings
do_gnome() {
    HOST_FULL=$(hostname)
    HOST_PART=${HOST_FULL:0:3}
    if [[ $HOST_PART == "pop" ]]; then
        echo "Pop!_OS detected"
        eval `dircolors ../.dir_colors/dircolors`
        gsettings set org.gnome.desktop.background picture-options 'none'
        gsettings set org.gnome.desktop.background primary-color '#282a36'
    fi
}

# Parse flags
apt=false pip=false links=false gnome=false

if [[ $# -eq 0 ]]; then
    usage
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        --apt)   apt=true ;;
        --pip)   pip=true ;;
        --links) links=true ;;
        --gnome) gnome=true ;;
        --all)   apt=true; pip=true; links=true; gnome=true ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown flag: $1"; usage; exit 1 ;;
    esac
    shift
done

$apt   && do_apt
$pip   && do_pip
$links && do_links
$gnome && do_gnome
