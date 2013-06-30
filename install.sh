#!/bin/sh
cd ~

ln -s ~/config/vim/vimrc ~/.vimrc
ln -s ~/config/vim ~/.vim
mkdir ~/config/vim/undo
mkdir ~/config/vim/tags

ln -s ~/config/zsh/zshrc ~/.zshrc
ln -s ~/config/zsh ~/.zsh

ln -s ~/config/Xresources ~/.Xresources
ln -s ~/config/tmux.conf ~/.tmux.conf
ln -s ~/config/config/powerline ~/.config/powerline
ln -s ~/config/dircolors-solarized/dircolors.ansi-dark ~/.dir_colors

cd ~/config
git submodule init && git submodule update

