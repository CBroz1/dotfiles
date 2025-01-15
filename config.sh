#! /bin/bash
DOTFILES=(.bash_profile .gitconfig .gitignore .mdlcr .tmux.conf .vimrc .zshrc .xbindkeysrc)

#Remove old dotfiles and replace them
for dotfile in "${DOTFILES[@]}";
do
    rm ~/"$dotfile" || true
    ln -s ~/dotfiles/"$dotfile" ~/"$dotfile"
done

sudo apt update -y
sudo apt install $(cat ./install_scripts/apt_installs_pop.txt) -y
sudo npm install saltthepass

gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#282a36'
eval `dircolors /home/$USER/.dir_colors/dircolors`

# DOCKER
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod 777 /var/run/docker.sock

mkdir -p ~/.local/bin
ln -s ~/dotfiles/salt ~/.local/bin/salt
