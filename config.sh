#! /bin/bash

DOTFILES=(.bash_profile .gitconfig .gitignore)

#Remove old dotfiles and replace them
for dotfile in "${DOTFILES[@]}";
do
    rm ~/"$dotfile"
    ln -s ~/dotfiles/"$dotfile" ~/"$dotfile"
done
