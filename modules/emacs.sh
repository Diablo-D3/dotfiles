#!/usr/bin/env bash

NOW=$(date "+%s")

GIT="/usr/bin/git"
EMACS="/usr/bin/emacs"
EMACSD="$HOME/.emacs.d"
EMACSD_VER="$EMACSD.ver"
DOOMBIN="${EMACSD}/bin/doom"
DOOM=("$EMACS" --no-site-file --script "$DOOMBIN" --)

if [ ! -d "$EMACSD" ]; then
    "$GIT" clone --depth 1 "https://github.com/hlissner/doom-emacs" "$EMACSD"
    "${DOOM[@]}" -y install --no-fonts
    "${DOOM[@]}" sync
    echo "$NOW" >"$EMACSD_VER"
else
    if [ ! -f "$EMACSD_VER" ] || [ "$(<"$EMACSD_VER")" -gt $(("$NOW" + 86400)) ]; then
        "$GIT" -C "$EMACSD" pull --rebase
        "${DOOM[@]}" clean
        "${DOOM[@]}" sync -u -p
        echo "$NOW" >"$EMACSD_VER"
    else
        _status "Doom sync ran recently, skipping"
    fi
fi

if [ -n "${WSL+set}" ]; then
    GIT="${SCOOP}git.exe"
    EMACS="${SCOOP}emacs.exe"
    EMACSD="$APPDATAW\\.emacs.d"
    EMACSDL="$APPDATA/.emacs.d"
    EMACSD_VER="$EMACSDL.ver"
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
        echo "$NOW" >"$EMACSD_VER"
    else
        if [ ! -f "$EMACSD_VER" ] || [ "$(<"$EMACSD_VER")" -gt $(("$NOW" + 86400)) ]; then
            "$GIT" -C "$EMACSD" pull --rebase
            "${DOOM[@]}" clean
            "${DOOM[@]}" sync -u -p
            echo "$NOW" >"$EMACSD_VER"
        fi
    fi
fi

# Install Iosevka
wget -q "https://raw.githubusercontent.com/be5invis/iosevka/master/package.json" -O "/tmp/package.json"

# Match '"version":', one or more whitespace, a double quote, one or more
# whitespace, then flush the match; match one or more non-whitespace until you
# reach one or more whitespace, a double quote, one or more whitespaces, and
# then a comma.
REGEX='"version":\s*"\s*\K\S+(?=\s*"\s*,)'

I_VER="$(grep -oP "$REGEX" "/tmp/package.json")"
I_URL="https://github.com/be5invis/Iosevka/releases/download/v$I_VER"

I_VER_FILE="$HOME/.fonts/.iosevka.ver"

_mkdir "$HOME/.fonts"

if [ ! -f "$I_VER_FILE" ] || [ "$I_VER" != "$(<"$I_VER_FILE")" ]; then
    _status "\nInstalling Iosevka $I_VER"

    wget -q "$I_URL/super-ttc-iosevka-$I_VER.zip" -O "/tmp/iosevka.zip"
    unzip -jo "/tmp/iosevka.zip" "iosevka.ttc" -d "$HOME/.fonts/"

    wget -q "$I_URL/super-ttc-iosevka-aile-$I_VER.zip" -O "/tmp/iosevka-aile.zip"
    unzip -jo "/tmp/iosevka-aile.zip" "iosevka-aile.ttc" -d "$HOME/.fonts/"

    echo "$I_VER" >"$I_VER_FILE"
else
    _status "Iosevka $I_VER already installed, skipping"
fi

exit 0
