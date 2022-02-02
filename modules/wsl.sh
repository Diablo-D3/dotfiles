#!/usr/bin/env bash

if [ -v WSL ]; then
    _ln "$USERPROFILE/Desktop" "$HOME/Desktop"
    _ln "$USERPROFILE/Documents" "$HOME/Documents"
    _ln "$USERPROFILE/Downloads" "$HOME/Downloads"
    _ln "$USERPROFILE/workspace" "$HOME/workspace"

    _mkdir "$USERPROFILE/bin"
    _ln "$USERPROFILE/bin" "$HOME/bin/windows"

    _ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    _ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    _ln "$MODULE_DIR/hidden_powershell.js" "$USERPROFILE/hidden_powershell.js"
    _ln "$MODULE_DIR/wsl2.ps1" "$USERPROFILE/wsl2.ps1"

    if [ ! -f "/mnt/c/Program Files/Alacritty/alacritty.exe" ]; then
        winget.exe install alacritty.alacritty
    else
        winget.exe upgrade alacritty.alacritty
    fi

    _ln "$MODULES_DIR/alacritty/HOME/alacritty.yml" "$APPDATA/alacritty/alacritty.yml"

    if [ ! -f "/mnt/c/Program Files/Git/bin/git.exe" ]; then
        winget.exe install git.git
    else
        winget.exe upgrade git.git
    fi
fi
