#!/bin/sh
cd "$(dirname "$0")" || exit

ln -sf ~/.dotfiles/vim/vimrc ~/.vimrc
ln -nsf ~/.dotfiles/vim ~/.vim
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/tags

rm ~/.bashrc
rm ~/.bash_profile
ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/.dotfiles/bash_profile ~/.bash_profile

ln -sf ~/.dotfiles/Xresources ~/.Xresources
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/minttyrc ~/.minttyrc
ln -sf ~/.dotfiles/toprc ~/.toprc
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

mkdir -p ~/.mintty
ln -nsf ~/.dotfiles/base16-mintty/mintty ~/.mintty/themes

git pull
