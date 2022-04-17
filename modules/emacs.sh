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

if [ -n "${WSL+set}" ]; then
    GIT="${SCOOP}git.exe"
    EMACS="${SCOOP}emacs.exe"
    EMACSD="$APPDATAW\\.emacs.d"
    EMACSDL="$APPDATA/.emacs.d"
    DOOMBIN="${EMACSD}\\bin\\doom"
    DOOM=("$EMACS" --no-site-file --script "$DOOMBIN" --)

    if [ ! -x "$GIT" ] || [ ! -x "$EMACS" ] || [ ! -x "${SCOOP}fd.exe" ] || [ ! -x "${SCOOP}rg.exe" ]; then
        _scoop install "git" "extras/emacs" "fd" "ripgrep"
    else
        _scoop update "git" "extras/emacs" "fd" "ripgrep"
    fi

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
