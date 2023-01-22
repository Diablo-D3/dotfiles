#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _stow "$module_home/config/alacritty" "$APPDATA/alacritty/"
fi

fonts="$HOME/.fonts"

_mkdir "$fonts"

# _gh_dl "be5invis" "iosevka" "super-ttc-iosevka" "-VER" ".zip" "$fonts/iosevka.ttc"
# _gh_dl "be5invis" "iosevka" "super-ttc-iosevka-aile" "-VER" ".zip" "$fonts/iosevka-aile.ttc"
#
# if [ -f "/tmp/super-ttc-iosevka.zip" ]; then
#     unzip -qqjo "/tmp/super-ttc-iosevka.zip" "iosevka.ttc" -d "$fonts"
#     unzip -qqjo "/tmp/super-ttc-iosevka-aile.zip" "iosevka-aile.ttc" -d "$fonts"
#     rm -f "/tmp/super-ttc-iosevka.zip" "/tmp/super-ttc-iosevka-aile.zip"
#
#     if [ -n "${wsl+set}" ]; then
#         oldpwd="$PWD"
#         cd "$fonts" || exit
#         _ln "$modules_dir/os-wsl/fontreg.exe" "$USERPROFILE/bin/fontreg.exe"
#         powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
#         cd "$oldpwd" || exit
#     fi
# fi

exit 0
