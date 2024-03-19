#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ ! -f "${HOME}/.terminfo/a/alacritty" ]]; then
	wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
	tic -x -o "${HOME}/.terminfo" "/tmp/alacritty.info"

	rm -f "/tmp/alacritty.info"
fi

if [[ ! -f "${HOME}/.terminfo/w/wezterm" ]]; then
	wget -q "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" -O "/tmp/wezterm.info"
	tic -x -o "${HOME}/.terminfo" "/tmp/wezterm.info"

	rm -f "/tmp/wezterm.info"
fi
