#!/bin/sh
cd ~/config

git pull
git submodule update --rebase --recursive

cd ~/config/vim/bundle/YouCompleteMe/
./install.sh

