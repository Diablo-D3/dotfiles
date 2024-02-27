#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

_check_time "86400" "${HOME}/.bin/nvim"

if [[ "${__check_time}" -eq 0 ]]; then
	wget -O "${HOME}/.bin/nvim" "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
	chmod u+x "${HOME}/.bin/nvim"
fi
