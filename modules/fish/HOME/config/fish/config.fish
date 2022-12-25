#!/usr/bin/fish

# disable greeting
set -gx fish_greeting ""
set -g fish_term24bit 0

# if xterm or tmux, assume 24 bit support
if string match xterm "$TERM" || string match tmux "$TERM"
    then
    set -gx COLORTERM "truecolor"
end

# path: home, $PATH, sbin
# global is assumed to contain at least: /usr/local/bin:/usr/bin:/bin
set -gx PATH $HOME/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin

# normalize locale
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "$LANG"
set -gx LC_CTYPE "$LANG"

# test phrase
set -gx SPHINX "sphinx of black quartz judge my vow\nSPHINX OF BLACK QUARTZ JUDGE MY VOW"

# hostname color
set -gx HOSTCHECKSUM (echo "$hostname" | md5sum | tr '[:lower:]' '[:upper:]' | cut '-b1-2')
set -gx HOSTCOLOR (math 0x"$HOSTCHECKSUM" % 16)

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

function fish_preexec
    if tet -n "$TMUX"
        then
        eval "tmux show-environment -s"
        eval "~/.tmux/plugins/tmux-continuum/scripts/continuum_save.sh"
    end
end

# set xterm title
function fish_title
    if test $_ = 'fish'
        echo (string join "" (prompt_hostname) ": " (prompt_pwd))
    else
        echo (string join "" (prompt_hostname) ": $_")
    end
end
