#!/usr/bin/env bash

# this function is evil and uses global variables externally
function _doom_setup {
    if [ ! -d "$emacsdu" ]; then
        _status "Installing Doom for the first time"
        "$git" clone --depth 1 "https://github.com/hlissner/doom-emacs" "$emacsdn"
        "${doom[@]}" -y install --no-fonts
        "${doom[@]}" sync
        _check_time "$emacsdu" "0"
    else
        if $(_check_time "$emacsdu" "86400"); then
            _status "Updating Doom repo"
            "$git" -C "$emacsdn" pull --rebase
        fi

        if $(_check_repo "$emacsdu"); then
            _status "Running Doom package update and sync"
            "${doom[@]}" clean
            "${doom[@]}" sync -u -p
        elif $(_check_file "$doomd/packages.el" "$doomd/init.el"); then
            _status "Running Doom sync"
            "${doom[@]}" sync
        else
            _status "Recently ran Doom sync, skipping"
        fi
    fi
}

git="/usr/bin/git"
emacs="/usr/bin/emacs"
emacsdu="$HOME/.emacs.d" # unix path
emacsdn="$HOME/.emacs.d" # native path
doom=("$emacs" --no-site-file --script "$emacsdn/bin/doom" --)
doomd="$HOME/.doom.d"

_doom_setup

if [ -n "${WSL+set}" ]; then
    git="${SCOOP_DIR}/git.exe"
    emacs="${SCOOP_DIR}/emacs.exe"
    emacsdu="$APPDATA/.emacs.d"
    emacsdn="$APPDATAW\\.emacs.d"
    doom=("$emacs" --no-site-file --script "$emacsdn\\bin\doom" --)
    doomd="$APPDATA/.doom.d"

    if [ ! -x "$git" ] ||
           [ ! -x "$emacs" ] ||
           [ ! -x "${SCOOP_DIR}/fd.exe" ] ||
           [ ! -x "${SCOOP_DIR}/rg.exe" ]; then
        _scoop install "git" "extras/emacs" "fd" "ripgrep"
    fi

    _ln_descent "$MODULE_DIR/HOME/doom.d" "$doomd"

    _doom_setup
fi

# Install Iosevka
if $(_check_time "$HOME/.fonts/iosevka.ttc" "86400"); then
    _status "Checking Iosevka"

    wget -q "https://raw.githubusercontent.com/be5invis/iosevka/master/package.json" -O "/tmp/package.json"

    # Match '"version":', one or more whitespace, a double quote, one or more
    # whitespace, then flush the match; match one or more non-whitespace until you
    # reach one or more whitespace, a double quote, one or more whitespaces, and
    # then a comma.
    regex='"version":\s*"\s*\K\S+(?=\s*"\s*,)'

    ver="$(grep -oP "$regex" "/tmp/package.json")"
    url="https://github.com/be5invis/Iosevka/releases/download/v$ver"
    fonts="$HOME/.fonts"

    _mkdir "$fonts"

    if $(_check_ver "$HOME/.fonts/iosevka.ttc" "$ver"); then
        _status "Installing Iosevka $ver"

        wget -q "$url/super-ttc-iosevka-$ver.zip" -O "/tmp/iosevka.zip"
        unzip -jo "/tmp/iosevka.zip" "iosevka.ttc" -d "$fonts"

        wget -q "$url/super-ttc-iosevka-aile-$ver.zip" -O "/tmp/iosevka-aile.zip"
        unzip -jo "/tmp/iosevka-aile.zip" "iosevka-aile.ttc" -d "$fonts"
    else
        _status "Iosevka $ver already installed, skipping"
    fi

    if [ -n "${WSL+set}" ]; then
        winfont="$LOCALAPPDATA/Microsoft/Windows/Fonts"
        _ln "$fonts/iosevka.ttc" "$winfont/iosevka.ttc"
        _ln "$fonts/iosevka-aile.ttc" "$winfont/iosevka-aile.ttc"
    fi
else
    _status "Recently checked Iosevka, skipping"
fi

exit 0
