#!/usr/bin/env bash

if [ -n "${WSL+set}" ]; then
    _ln "$USERPROFILE/Desktop" "$HOME/Desktop"
    _ln "$USERPROFILE/Documents" "$HOME/Documents"
    _ln "$USERPROFILE/Downloads" "$HOME/Downloads"

    _ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    _ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    _ln "$MODULE_DIR/hidden_powershell.js" "$USERPROFILE/hidden_powershell.js"
    _ln "$MODULE_DIR/wsl2.ps1" "$USERPROFILE/wsl2.ps1"

    _ln_descent "$HOME/.ssh" "$USERPROFILE/.ssh/"

    _scoop update
fi