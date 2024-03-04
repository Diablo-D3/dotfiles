#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ -n "${WSL+set}" ]]; then
	_stow "${MODULE_HOME:?}/config/wezterm" "${USERPROFILE:?}/.config/wezterm/"
fi
