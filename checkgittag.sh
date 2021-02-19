#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 [path to git repo]"
  exit -1
fi

UPSTREAM=$(git -C $1 tag --sort=v:refname | tail -1)
LOCAL=$(git -C $1 describe --abbrev=0 --tags)

printf "Current version is %s, you have %s\n" "$UPSTREAM" "$LOCAL"
