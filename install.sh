#!/bin/sh
cd ~

ln -s ~/config/vim/vimrc ~/.vimrc
ln -s ~/config/vim ~/.vim
mkdir ~/config/vim/undo
mkdir ~/config/vim/tags

rm ~/.bashrc
rm ~/.bash_profile
ln -s ~/config/bashrc ~/.bashrc
ln -s ~/config/bash_profile ~/.bash_profile

ln -s ~/config/Xresources ~/.Xresources
ln -s ~/config/tmux.conf ~/.tmux.conf
ln -s ~/config/minttyrc ~/.minttyrc
ln -s ~/config/toprc ~/.toprc

cd ~/config
git submodule update --init --recursive

