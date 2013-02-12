# Begin copy from Ubuntu 12.04 default

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable 256 color support in terminal
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# End copy from Ubuntu 12.04 default

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Use vim as readline editor
export editor=vim
set -o vi

# Misc command shortcuts
alias ls='ls --color=tty'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias l='unified_look'
alias grep='grep --color'
alias igrep='grep --color -i'

# Get name of current branch
parse_git_branch() {
	cur_branch=$(git branch --no-color 2> /dev/null | fgrep '*' | sed 's/* //')
	[ ${#cur_branch} -gt 0 ] && echo "(git:$cur_branch) "
}

# Convenience function to replace ls and less/more
unified_look() {
	if [ $# -eq 0 ]; then
		ll
	elif [ $# -gt 1 ]; then
		return
	elif [ -d $1 ]; then
		ll $1
	else
		more $1
	fi
}

# Show all user processes matching regex
epgrep() {
	[ $# -ne 1 ] && return
	ps ux | grep -e "$1" | grep -v "grep" | awk '{print $2}'
}

# SIGKILL all user processes matching regex
ekill() {
	[ $# -ne 1 ] && return
	epgrep "$1" | xargs -i kill -9 {}
}

# Expand relative paths and symlinks
abspath() {
	[ $# -ne 1 ] && return
	readlink -f "$1"
}

# Prompt
export PS1="\[\e[1;33m\]\u@\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \$(parse_git_branch)$ "

# Colors for ls
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=01;40;33:so=01;35:bd=01;40;33:cd=01;40;33:or=01;05;37;41:mi=01;05;37;41:ex=01;32'

# Load ~/.bashrc.local if it exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
