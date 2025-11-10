#!/usr/bin/fish

# disable greeting
set -U fish_greeting

# set color theme
set -g fish_term24bit 0
set -g fish_term256 0
fish_config theme choose None

# hostname color
set -g HOSTCHECKSUM (echo "$hostname" | md5sum | tr '[:lower:]' '[:upper:]' | cut '-b1-2')
set -g HOSTCOLOR (math 0x"$HOSTCHECKSUM" % 16)

# add git-prompt when available
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showstashstate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showupstream auto

# set prompt
function fish_prompt
    set PRO_START (string join "" "[" (tput setaf $HOSTCOLOR) (prompt_hostname) (set_color normal) " " (prompt_pwd))

    if test (id -u) -eq 0
        then
        set PRO_END "]" (set_color red) "# " (set_color normal)
    else
        set PRO_END "]\$ "
    end
    if test "$PWD" != "$HOME"
        printf '%s%s%s' "$PRO_START" (fish_git_prompt) "$PRO_END"
    else
        printf '%s%s' "$PRO_START" "$PRO_END"
    end
end

# set xterm title
function fish_title
    if test $_ = fish
        echo (string join "" (prompt_hostname) ": " (prompt_pwd))
    else
        echo (string join "" (prompt_hostname) ": $_")
    end
end

# fd
if type -q fdfind
    alias fd="fdfind"
end

# vim and helix
alias vim="$EDITOR"
