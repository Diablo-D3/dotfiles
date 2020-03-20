#!/bin/sh
cd ~

ln -sf ~/config/vim/vimrc ~/.vimrc
ln -nsf ~/config/vim ~/.vim
mkdir -p ~/config/vim/undo
mkdir -p ~/config/vim/tags

rm ~/.bashrc
rm ~/.bash_profile
ln -sf ~/config/bashrc ~/.bashrc
ln -sf ~/config/bash_profile ~/.bash_profile

ln -sf ~/config/Xresources ~/.Xresources
ln -sf ~/config/tmux.conf ~/.tmux.conf
ln -sf ~/config/minttyrc ~/.minttyrc
ln -sf ~/config/toprc ~/.toprc

cd ~/config
git submodule update --init --recursive
./update.sh

mkdir -p ~/.mintty
ln -nsf ~/config/base16-mintty/mintty ~/.mintty/themes

