#! /bin/bash
DOTFILES=(.bash_profile .gitconfig .gitignore .mdlcr .tmux.conf .vimrc .zshrc .xbindkeysrc)

#Remove old dotfiles and replace them
for dotfile in "${DOTFILES[@]}";
do
    rm ~/"$dotfile" || true
    ln -s ~/dotfiles/"$dotfile" ~/"$dotfile"
done

CONFIGS=(.codespellrc gh/config.yml) # TODO: add more
mkdir -p ~/.config
for config in "${CONFIGS[@]}";
do
    rm ~/.config/"$config" || true
    ln -s ~/dotfiles/"$config" ~/.config/"$config"
done

# apt installs
sudo apt update -y
sudo apt install $(cat ./install_scripts/apt_installs_pop.txt) -y
sudo npm install saltthepass

# dircolors
mkdir -p ~/.dir_colors
ln -s ~/dotfiles/.dir_colors/dircolors /.dir_colors/dircolors
eval `dircolors /home/$USER/.dir_colors/dircolors`

# background
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#282a36'

# DOCKER
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod 777 /var/run/docker.sock

# npm
while IFS= read -r package || [[ -n "$package" ]]; do
    if [[ ! -z "$package" ]]; then
        npm install -g "$package"
    fi
done < ./install_scripts/npm_installs_pop.txt

# utils
mkdir -p ~/.local/bin
ln -s ~/dotfiles/salt ~/.local/bin/salt # todo: move to dotfiles/bin
ln -s ~/dotfiles/killpulse ~/.local/bin/killpulse

# Python installs
pip install --upgrade pip
pip install -r ./install_scripts/py_installs_pop.txt
