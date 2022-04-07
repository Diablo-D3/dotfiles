#!/usr/bin/env bash

GIT="/usr/bin/git"
EMACS="/usr/bin/emacs"
EMACSD="$HOME/.emacs.d"
DOOMBIN="${EMACSD}/bin/doom"
DOOM=("$EMACS" --no-site-file --script "$DOOMBIN" --)

if [ ! -d "$EMACSD" ]; then
    "$GIT" clone --depth 1 "https://github.com/hlissner/doom-emacs" "$EMACSD"
    "${DOOM[@]}" -y install --no-fonts
    "${DOOM[@]}" sync
else
    "$GIT" -C "$EMACSD" pull --rebase
    "${DOOM[@]}" clean
    "${DOOM[@]}" sync -u -p
fi

if [ -v WSL ]; then
    GIT="${SCOOP}git.exe"
    EMACS="${SCOOP}emacs.exe"
    EMACSD="$APPDATAW\\.emacs.d"
    EMACSDL="$APPDATA/.emacs.d"
    DOOMBIN="${EMACSD}\\bin\\doom"
    DOOM=("$EMACS" --no-site-file --script "$DOOMBIN" --)

    _scoop_install_or_update "$GIT" "git"
    _scoop_install_or_update "$EMACS" "extras/emacs"
    _scoop_install_or_update "${SCOOP}fd.exe" "fd"
    _scoop_install_or_update "${SCOOP}rg.exe" "ripgrep"

    _ln_descent "$MODULE_DIR/HOME/doom.d" "$APPDATA/.doom.d"

    if [ ! -d "$EMACSDL" ]; then
        "$GIT" clone --depth 1 "https://github.com/hlissner/doom-emacs" "$EMACSD"
        "${DOOM[@]}" -y install --no-fonts
        "${DOOM[@]}" sync
    else
        "$GIT" -C "$EMACSD" pull --rebase
        "${DOOM[@]}" clean
        "${DOOM[@]}" sync -u -p
    fi
fi

exit 0
