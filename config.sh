#! /bin/bash
# AUTHOR: Chris Brozdowski
# DATE: 2025-02-14
#
# DESCRIPTION: This script is used to configure a new Pop!_OS installation.
# 1. Updates apt and installs packages from apt_installs_pop.txt
# 2. Installs npm packages from npm_installs_pop.txt
# 3. Installs python packages from py_installs_pop.txt
# 4. Adds user to docker group
# 5. Links files in dotfiles to home directory by relative path

# # apt installs
if ! sudo -n true 2>/dev/null; then
    echo "Please rerun as sudo to install packages"
else
    # Apt installs
    sudo add-apt-repository ppa:libreoffice/ppa > /dev/null # libreoffice
    sudo add-apt-repository ppa:deadsnakes/ppa > /dev/null # python versions
    sudo apt update -y > /dev/null
    sudo apt install $(cat ./install_scripts/apt_installs_pop.txt) -y > /dev/null
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
fi


# Python installs
if command -v pip &> /dev/null; then
    pip install --upgrade pip > /dev/null 2>&1
    pip install -r ./install_scripts/py_installs_pop.txt > /dev/null 2>&1
else
    echo "Skipping python installs: pip not found"
fi

# # link dotfiles
cd ~/dotfiles || { echo "Error: Could not access ~/dotfiles"; exit 1; }
exclude=("install_scripts*" "*key" "code*" "READ*" "*osx*" "*config.sh")
git ls-files --exclude-standard | while read file; do # ignore .gitignore files
    for pattern in "${exclude[@]}"; do
        if [[ "$file" == $pattern ]]; then
            continue 2  # Skips to the next file in `while` loop
        fi
    done
    target="$HOME/$file"  # Place symlink in home directory
    mkdir -p "$(dirname "$target")"  # Ensure parent directories exist
    if ! [ -f "$target" ]; then
        echo "ADD  $PWD/$file → $target"
        ln -s "$PWD/$file" "$target"
    elif [[ "$file" == *git* || "$file" == *gh* ]]; then
        echo "SKIP $PWD/$file → $target"
    else
        echo "REPL $PWD/$file → $target"
        rm "$target" || true
        ln -s "$PWD/$file" "$target"
    fi
done

HOST_FULL=$(hostname)
HOST_PART=${HOST_FULL:0:3}
if [[ $HOST_PART == "pop" ]]; then
    echo "Pop!_OS detected"
    eval `dircolors /home/$USER/.dir_colors/dircolors`
    gsettings set org.gnome.desktop.background picture-options 'none'
    gsettings set org.gnome.desktop.background primary-color '#282a36'
fi

