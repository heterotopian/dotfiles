# .bash_common

# Use vim as readline editor
export editor=vim
set -o vi

# Misc command shortcuts
alias ls='ls --color=tty'
alias la='ls -la --color=tty'
alias ll='ls -l --color=tty'
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

# Show running time in seconds using bash builtin
wallseconds() {
	TIMEFORMAT=%0R
	{ time ${@} > /dev/null; } 2>&1
} 

# Prompt
export PS1="\[\e[1;33m\]\u@\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \$(parse_git_branch)$ "

# Colors for ls
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=01;40;33:so=01;35:bd=01;40;33:cd=01;40;33:or=01;05;37;41:mi=01;05;37;41:ex=01;32'


