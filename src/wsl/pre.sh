#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ -n "${WSL+set}" ]]; then
	# Standard user directories
	_ln "${USERPROFILE:?}/Desktop" "${HOME}/Desktop"
	_ln "${USERPROFILE:?}/Documents" "${HOME}/Documents"
	_ln "${USERPROFILE:?}/Downloads" "${HOME}/Downloads"

	# Microsoft Terminal
	_ln "${MODULE_DIR:?}/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
	_ln "${MODULE_DIR:?}/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

	# Script for starting WSL2 at bootime
	_ln "${MODULE_DIR:?}/install-task.ps1" "${USERPROFILE:?}/install-task.ps1"
	_ln "${MODULE_DIR:?}/hidden_powershell.js" "${USERPROFILE:?}/hidden_powershell.js"
	_ln "${MODULE_DIR:?}/wsl2.ps1" "${USERPROFILE:?}/wsl2.ps1"

	# Synchronize ssh keys
	_stow "${HOME}/.ssh" "${USERPROFILE:?}/.ssh/"

	# Manually run kanata pre.sh
	. "${MODULES_DIR:?}/kanata/pre.sh"
fi
