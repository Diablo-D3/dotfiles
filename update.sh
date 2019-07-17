#!/bin/sh
git pull
git submodule foreach git pull origin master
git submodule foreach git checkout --theirs master
git submodule foreach git reset --hard

