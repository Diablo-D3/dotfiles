#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _ln "$USERPROFILE/Desktop" "$HOME/Desktop"
    _ln "$USERPROFILE/Documents" "$HOME/Documents"
    _ln "$USERPROFILE/Downloads" "$HOME/Downloads"

    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    _ln "$module_dir/install-task.ps1" "$USERPROFILE/install-task.ps1"
    _ln "$module_dir/hidden_powershell.js" "$USERPROFILE/hidden_powershell.js"
    _ln "$module_dir/wsl2.ps1" "$USERPROFILE/wsl2.ps1"

    _stow "$HOME/.ssh" "$USERPROFILE/.ssh/"

    _mkdir "$USERPROFILE/kmonad"
    _stow "$modules_dir/kmonad" "$USERPROFILE/kmonad"

    tmp="/tmp/kmonad-win.exe"
    target="$USERPROFILE/kmonad/kmonad-win.exe.new"

    rm -f "$tmp"

    # kmonad doesn't use GH releases correctly atm
    # https://github.com/kmonad/kmonad/issues/614
    # _gh_dl "kmonad" "kmonad" "kmonad" "-VER" "-win.exe" "$path"
    if _check_time "$target" "86400"; then
        wget -q "https://github.com/kmonad/kmonad/releases/download/0.4.1/kmonad-0.4.1-win.exe" -O "$tmp"
    fi

    if [ -f "$tmp" ]; then
        _ln "$tmp" "$target"

        rm -f "$tmp"
    fi
fi
