#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

_check_time "86400" "${HOME}/.terminfo"
if [[ "${__check_time}" -eq 0 ]]; then
	wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
	tic -x -o "${HOME}/.terminfo" "/tmp/alacritty.info"
fi
