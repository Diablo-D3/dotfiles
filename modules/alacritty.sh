#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _stow "$module_home/config/alacritty" "$APPDATA/alacritty/"
fi

fonts="$HOME/.fonts"

_mkdir "$fonts"

_gh_dl "be5invis" "iosevka" "ttf-iosevka-term" "-VER" ".zip" "$fonts/iosevka-term-regular.ttf"
_gh_dl "be5invis" "iosevka" "ttf-iosevka-aile" "-VER" ".zip" "$fonts/iosevka-aile-regular.ttf"

if [ -f "/tmp/ttf-iosevka-term.zip" ]; then
    unzip -qqjo "/tmp/ttf-iosevka-term.zip" "iosevka-term-extended*ttf" -d "$fonts"
    unzip -qqjo "/tmp/ttf-iosevka-aile.zip" "iosevka*ttf" -d "$fonts"
    rm -f "/tmp/ttf-iosevka-term.zip" "/tmp/ttf-iosevka-aile.zip"

    if [ -n "${wsl+set}" ]; then
        oldpwd="$PWD"
        cd "$fonts" || exit
        _ln "$modules_dir/os-wsl/fontreg.exe" "$USERPROFILE/bin/fontreg.exe"
        powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
        cd "$oldpwd" || exit
    fi
fi

exit 0
