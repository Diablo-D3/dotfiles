#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

check_time=$(_check_time "86400" "${HOME}/.terminfo")
if ${check_time}; then
	wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
	tic -x -o "${HOME}/.terminfo" "/tmp/alacritty.info"
fi
