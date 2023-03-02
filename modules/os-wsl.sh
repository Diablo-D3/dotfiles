#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    # Standard user directories
    _ln "$USERPROFILE/Desktop" "$HOME/Desktop"
    _ln "$USERPROFILE/Documents" "$HOME/Documents"
    _ln "$USERPROFILE/Downloads" "$HOME/Downloads"

    # Microsoft Terminal
    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    _ln "$module_dir/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    # Script for starting WSL2 at bootime
    _ln "$module_dir/install-task.ps1" "$USERPROFILE/install-task.ps1"
    _ln "$module_dir/hidden_powershell.js" "$USERPROFILE/hidden_powershell.js"
    _ln "$module_dir/wsl2.ps1" "$USERPROFILE/wsl2.ps1"

    # Synchronize ssh keys
    _stow "$HOME/.ssh" "$USERPROFILE/.ssh/"

    # Kanata
    _stow "$modules_dir/kanata" "$USERPROFILE/kanata"

    tmp="/tmp/kanata.exe"
    target="$USERPROFILE/kanata/kanata.exe.new"

    rm -f "$tmp"

    _gh_dl "jtroo" "kanata" "kanata" "" ".exe" "$target"

    if [ -f "$tmp" ]; then
        _ln "$tmp" "$target"
        rm -f "$tmp"
    fi
fi
