#!/usr/bin/env bash

_ln "$USERPROFILE/Desktop" "$HOME/Desktop"
_ln "$USERPROFILE/Documents" "$HOME/Documents"
_ln "$USERPROFILE/Downloads" "$HOME/Downloads"
_ln "$USERPROFILE/workspace" "$HOME/workspace"

_ln "$HOME/.cache" "$USERPROFILE/.cache"
_ln "$HOME/.ssh" "$USERPROFILE/.ssh"
_ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
_ln "$MODULE_DIR/windowsterminal.settings.json" "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

