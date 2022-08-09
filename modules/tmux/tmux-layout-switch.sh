#!/bin/sh

width=$(tmux display-message -p "#{window_width}")
height=$(tmux display-message -p "#{window_height}")
size="(${width}x${height})"

zoomed=$(tmux display-message -p "#{window_zoomed_flag}")

timeout=1

if [ "$width" -gt "132" ]; then
	tmux select-layout main-vertical
	tmux display-message -d $timeout "Vertical $size"
elif [ "$height" -gt "24" ]; then
	tmux select-layout main-horizontal
	tmux display-message -d $timeout "Horizontal $size"
elif [ "$zoomed" -eq "0" ]; then
	tmux resize-pane -Z
	tmux display-message -d $timeout "Single $size"
else
	tmux display-message -d $timeout "Single $size"
fi

exit 0
