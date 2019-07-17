#!/bin/sh
git pull --recurse-submodules
git submodule foreach git checkout master
git submodule foreach git reset --hard

