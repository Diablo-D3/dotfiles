# Environment
PATH=$HOME/bin:node_modules/.bin:/usr/local/sbin:/usr/local/bin:/mingw64/bin:$PATH

LC_CTYPE=en_US.UTF-8

EDITOR=vim
VISUAL=vim
GIT_EDITOR=vim

if [[ -a ~/.bashrc.local ]]; then
	. ~/.bashrc.local
fi

shopt -s checkwinsize
shopt -s globstar 2> /dev/null
shopt -s nocaseglob;

bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

shopt -s histappend
shopt -s cmdhist

HISTSIZE=999999999
HISTFILESIZE=999999999
HISTCONTROL="erasedups:ignoreboth"

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

alias grep="grep --color=auto"
alias ls="ls --color=auto"


# base16
BASE16_SCHEME="bright"
BASE16_SHELL="$HOME/config/base16-shell/scripts/base16-$BASE16_SCHEME.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL


# prompt theme
RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 8)
ORANGE=$(tput setaf 16)
BROWN=$(tput setaf 17)

if [ $(id -u) -eq 0 ]; then
	PRO_SYM="\[$RED\]#\[$RESET\]"
else
	PRO_SYM="\$"
fi

HOSTCOLOR=0
I=1
J=2
while [ $HOSTCOLOR -eq 0 -o $HOSTCOLOR -eq 124 -o $HOSTCOLOR -gt 231 ]; do
	HOSTCHECKSUM=`echo $HOSTNAME | md5sum | cut -b$I-$J`
	HOSTCOLOR=`printf "%d" 0x$HOSTCHECKSUM`

	I=$[$I+1]
	J=$[$J+1]
done

case $HOSTCOLOR in
12)
	PRO_FG=$CYAN
	;;
174)
	PRO_FG=$BLUE
	;;
228)
	PRO_FG=$GREEN
	;;
*)
	PRO_FG=$(tput setaf $HOSTCOLOR)
	;;
esac

GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

if [[ -a /usr/share/git/completion/git-prompt.sh ]]; then
	source /usr/share/git/completion/git-prompt.sh
elif [[ -a /usr/lib/git-core/git-sh-prompt ]]; then
	source /usr/lib/git-core/git-sh-prompt
fi

PRO_START="[\[$PRO_FG\]\h\[$RESET\] \W"
PRO_END="]$PRO_SYM "

precmd() {
	if [[ $PWD != $HOME ]]; then
		__git_ps1 "$PRO_START" "$PRO_END"
	else
		PS1=$PRO_START$PRO_END
	fi

	if [[ -n $TMUX ]]; then
		eval $(tmux show-environment -s)
	fi

	history -a
}

PROMPT_COMMAND=precmd

preexec() {
	if [[ $BASH_COMMAND == "precmd" ]]; then
		COMMAND=$DIRSTACK
	else
		COMMAND=$BASH_COMMAND
	fi

	PRO_TITLE="\033]0;${HOSTNAME%%.*}: $COMMAND\007"
	echo -ne "$PRO_TITLE"
}

trap preexec DEBUG

