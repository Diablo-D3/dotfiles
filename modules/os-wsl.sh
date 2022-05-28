#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _ln "$USERPROFILE/Desktop" "$HOME/Desktop"
    _ln "$USERPROFILE/Documents" "$HOME/Documents"
    _ln "$USERPROFILE/Downloads" "$HOME/Downloads"

    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    _ln "$module_dir/hidden_powershell.js" "$USERPROFILE/hidden_powershell.js"
    _ln "$module_dir/wsl2.ps1" "$USERPROFILE/wsl2.ps1"

    _ln_descent "$HOME/.ssh" "$USERPROFILE/.ssh/"

    # Ensure Scoop is installed and is setup correctly
    if [ ! -x "${scoop_dir}/scoop" ]; then
        powershell.exe -Command "iwr -useb https://get.scoop.sh | iex"
        _scoop install git
        _scoop bucket add extras
    else
        _scoop update
    fi
fi
