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

    _ln "$MODULE_DIR/hidden_powershell.js" "$USERPROFILE"
    _ln "$MODULE_DIR/wsl2.ps1" "$USERPROFILE"
fi
