#!/bin/sh
cd "$(dirname "$0")" || exit

ln -sf ~/config/vim/vimrc ~/.vimrc
ln -nsf ~/config/vim ~/.vim
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/tags

rm ~/.bashrc
rm ~/.bash_profile
ln -sf ~/config/bashrc ~/.bashrc
ln -sf ~/config/bash_profile ~/.bash_profile

ln -sf ~/config/Xresources ~/.Xresources
ln -sf ~/config/tmux.conf ~/.tmux.conf
ln -sf ~/config/minttyrc ~/.minttyrc
ln -sf ~/config/toprc ~/.toprc
ln -sf ~/config/gitconfig ~/.gitconfig

mkdir -p ~/.mintty
ln -nsf ~/config/base16-mintty/mintty ~/.mintty/themes

git pull
