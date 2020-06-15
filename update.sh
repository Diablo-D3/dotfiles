#!/bin/sh
git config pull.ff only
git pull
git submodule foreach git config pull.ff only
git submodule foreach git pull
git submodule foreach git checkout master
git submodule foreach git reset --hard

