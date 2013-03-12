# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable 256 color support in terminal
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Use Vim as readline editor
export editor=vim
set -o vi

# Misc command shortcuts
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias grep='grep --color'
alias igrep='grep -i --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Get name of current branch
parse_git_branch() {
	cur_branch=$(git branch --no-color 2> /dev/null | fgrep '*' | sed 's/* //')
	[ ${#cur_branch} -gt 0 ] && echo "(git:$cur_branch) "
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
