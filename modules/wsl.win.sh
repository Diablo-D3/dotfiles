#!/usr/bin/env bash

xln "$USERPROFILE/Desktop" "$HOME/Desktop"
xln "$USERPROFILE/Documents" "$HOME/Documents"
xln "$USERPROFILE/Downloads" "$HOME/Downloads"
xln "$USERPROFILE/workspace" "$HOME/workspace"

xln "$HOME/.cache" "$USERPROFILE/.cache"
xln "$HOME/.ssh" "$USERPROFILE/.ssh"
xln "${MODULE_DIR}/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
xln "${MODULE_DIR}/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

