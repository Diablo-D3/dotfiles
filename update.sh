#!/bin/sh
cd ~/config

git pull
git submodule update --rebase --recursive

