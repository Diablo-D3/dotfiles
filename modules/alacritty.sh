#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _stow "$module_home/config/alacritty" "$APPDATA/alacritty/"
fi

if _check_time "$HOME/.fonts/iosevka.ttc" "86400"; then
    _status "Checking Iosevka"

    wget -q "https://raw.githubusercontent.com/be5invis/iosevka/master/package.json" -O "/tmp/package.json"

    # Match '"version":', one or more whitespace, a double quote, one
    # or more whitespace, then flush the match; match one or more
    # non-whitespace until you reach one or more whitespace, a double
    # quote, one or more whitespaces, and then a comma.
    regex='"version":\s*"\s*\K\S+(?=\s*"\s*,)'

    ver="$(grep -oP "$regex" "/tmp/package.json")"
    url="https://github.com/be5invis/Iosevka/releases/download/v$ver"
    fonts="$HOME/.fonts"

    iosevka_url="$url/super-ttc-iosevka-$ver.zip" 
    aile_url="$url/super-ttc-iosevka-aile-$ver.zip"

    _mkdir "$fonts"

    if _check_ver "$HOME/.fonts/iosevka.ttc" "$ver"; then
        _status "Installing Iosevka $ver"

        wget -q "$iosevka_url" -O "/tmp/iosevka.zip"
        unzip -jo "/tmp/iosevka.zip" "iosevka.ttc" -d "$fonts"

        wget -q "$aile_url" -O "/tmp/iosevka-aile.zip"
        unzip -jo "/tmp/iosevka-aile.zip" "iosevka-aile.ttc" -d "$fonts"
    else
        _status "Iosevka $ver already installed, skipping"
    fi

    if [ -n "${wsl+set}" ]; then
        oldpwd="$PWD"
        cd "$fonts" || exit
        fontreg.exe "/copy"
        cd "$oldpwd" || exit
    fi
else
    _status "Recently checked Iosevka, skipping"
fi

exit 0
