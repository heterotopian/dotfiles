# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Make colorized man pages interact better with `env`
man() {
    LESS_TERMCAP_mb=$'\e'"[1;31m" \
    LESS_TERMCAP_md=$'\e'"[1;31m" \
    LESS_TERMCAP_me=$'\e'"[0m" \
    LESS_TERMCAP_se=$'\e'"[0m" \
    LESS_TERMCAP_so=$'\e'"[1;44;33m" \
    LESS_TERMCAP_ue=$'\e'"[0m" \
    LESS_TERMCAP_us=$'\e'"[1;32m" \
    command man "$@"
}

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
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Get name of current branch
parse_git_branch() {
	cur_branch=$(git branch --no-color 2> /dev/null | fgrep '*' | sed 's/* //')
	[ ${#cur_branch} -gt 0 ] && echo "(git:$cur_branch) "
}

# Prompt
export PS1="\[\e[1;33m\]\u@\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \$(parse_git_branch)$ "

# Colors for ls
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=01;40;33:so=01;35:bd=01;40;33:cd=01;40;33:or=01;05;37;41:mi=01;05;37;41:ex=01;32'

# Load ~/.bashrc.local if it exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
