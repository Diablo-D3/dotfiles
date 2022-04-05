#!/bin/sh

width=$(tmux display-message -p "#{window_width}")
height=$(tmux display-message -p "#{window_height}")
size="(${width}x${height})"

zoomed=$(tmux display-message -p "#{window_zoomed_flag}")

if [ "$width" -gt "132" ]; then
    tmux select-layout main-vertical
    tmux display-message "Vertical $size"
elif [ "$height" -gt "24" ]; then
    tmux select-layout main-horizontal
    tmux display-message "Horizontal $size"
elif [ "$zoomed" -eq "0" ]; then
    tmux resize-pane -Z
    tmux display-message "Single $size"
else
    tmux display-message "Single $size"
fi
