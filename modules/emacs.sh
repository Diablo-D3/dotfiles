#!/usr/bin/env bash

EMACSD=".emacs.d"
DOOMD=".doom.d"

declare -a GIT=("git" "/mnt/c/Program Files/Git/bin/git.exe")
declare -a EMACS=("emacs" "/mnt/c/Program Files/Emacs/x86_64/bin/emacs.exe")
declare -a DIR=("$HOME/" "$APPDATA/")   # home dir as unix path
declare -a ARG=("$HOME/" "$APPDATAW\\") # home dir as native path
declare -a BIN=("/bin/doom" "\\bin\\doom")

if [ -z "$WSL" ]; then
    j=1
else
    j=2
    _ln_descent "$MODULE_HOME/doom.d" "$APPDATA/${DOOMD}/"
fi

for ((i = 0; i < j; i++)); do
    EMACSDIR="${ARG[$i]}${EMACSD}"
    DOOMBIN="${EMACSDIR}${BIN[$i]}"
    DOOM=("${EMACS[$i]}" --no-site-file --script "$DOOMBIN" --)

    if [ ! -d "${DIR[$i]}${EMACSD}" ]; then
        "${GIT[$i]}" clone --depth 1 "https://github.com/hlissner/doom-emacs" "${EMACSDIR}"
        "${DOOM[@]}" -y install
        "${DOOM[@]}" sync
    else
        "${DOOM[@]}" upgrade
    fi

done
