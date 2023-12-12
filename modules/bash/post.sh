#!/usr/bin/env bash

if _check_time "86400" "$HOME/.terminfo"; then
	wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
	tic -x -o "$HOME/.terminfo" "/tmp/alacritty.info"
fi
