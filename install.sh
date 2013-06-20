#!/bin/sh
cd ~

ln -s ~/config/vim/vimrc ~/.vimrc
ln -s ~/config/vim ~/.vim
mkdir ~/config/vim/undo
mkdir ~/config/vim/tags

ln -s ~/config/Xdefaults ~/.Xdefaults

ln -s ~/config/zsh/zshrc ~/.zshrc
ln -s ~/config/zsh ~/.zsh

ln -s ~/config/tmux.confg ~/.tmux.conf

cd ~/config
git submodule init && git submodule update

