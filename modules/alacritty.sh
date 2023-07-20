#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _stow "$MODULE_HOME/config/alacritty" "$APPDATA/alacritty/"
fi

fonts="$HOME/.fonts"
term="ttf-iosevka-term"
aile="ttf-iosevka-aile"

_mkdir "$fonts"

_gh_dl "be5invis" "iosevka" "$term" "-VER" ".zip" "$fonts/$term-regular.ttf"
_gh_dl "be5invis" "iosevka" "$aile" "-VER" ".zip" "$fonts/$aile-regular.ttf"

if [ -f "/tmp/$term.zip" ] || [ -f "/tmp/$aile" ]; then
    unzip -qqjo "/tmp/ttf-iosevka-term.zip" "*ttf" -d "$fonts"
    unzip -qqjo "/tmp/ttf-iosevka-aile.zip" "*ttf" -d "$fonts"
    rm -f "/tmp/$term.zip" "/tmp/$aile.zip"

    if [ -n "${WSL+set}" ]; then
        oldpwd="$PWD"
        cd "$fonts" || exit
        _ln "$MODULES_DIR/os-wsl/fontreg.exe" "$USERPROFILE/bin/fontreg.exe"
        powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
        cd "$oldpwd" || exit
    fi
fi

exit 0
