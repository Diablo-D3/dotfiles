#!/bin/sh
cd ~
ln -s ~/config/vim/vimrc ~/.vimrc
ln -s ~/config/vim ~/.vim
mkdir ~/config/vim/undo
mkdir ~/config/vim/tags
cd ~/config
git submodule init && git submodule update

