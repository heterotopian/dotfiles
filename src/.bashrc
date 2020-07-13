# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Terminal colors
TERM_RESET=$(tput sgr0)
TERM_BOLD=$(tput bold)

TERM_COLOR_WHITE=15
TERM_COLOR_BLACK=0
TERM_COLOR_RED=1
TERM_COLOR_GREEN=2
TERM_COLOR_YELLOW=3
TERM_COLOR_BLUE=4
TERM_COLOR_PURPLE=5
TERM_COLOR_CYAN=6
TERM_COLOR_LIGHTGRAY=7
TERM_COLOR_DARKGRAY=8

TERM_FG_WHITE=$(tput setaf ${TERM_COLOR_WHITE})
TERM_FG_BLACK=$(tput setaf ${TERM_COLOR_BLACK})
TERM_FG_RED=$(tput setaf ${TERM_COLOR_RED})
TERM_FG_GREEN=$(tput setaf ${TERM_COLOR_GREEN})
TERM_FG_YELLOW=$(tput setaf ${TERM_COLOR_YELLOW})
TERM_FG_BLUE=$(tput setaf ${TERM_COLOR_BLUE})
TERM_FG_PURPLE=$(tput setaf ${TERM_COLOR_PURPLE})
TERM_FG_CYAN=$(tput setaf ${TERM_COLOR_CYAN})
TERM_FG_LIGHTGRAY=$(tput setaf ${TERM_COLOR_LIGHTGRAY})
TERM_FG_DARKGRAY=$(tput setaf ${TERM_COLOR_DARKGRAY})

TERM_BG_WHITE=$(tput setab ${TERM_COLOR_WHITE})
TERM_BG_BLACK=$(tput setab ${TERM_COLOR_BLACK})
TERM_BG_RED=$(tput setab ${TERM_COLOR_RED})
TERM_BG_GREEN=$(tput setab ${TERM_COLOR_GREEN})
TERM_BG_YELLOW=$(tput setab ${TERM_COLOR_YELLOW})
TERM_BG_BLUE=$(tput setab ${TERM_COLOR_BLUE})
TERM_BG_PURPLE=$(tput setab ${TERM_COLOR_PURPLE})
TERM_BG_CYAN=$(tput setab ${TERM_COLOR_CYAN})
TERM_BG_LIGHTGRAY=$(tput setab ${TERM_COLOR_LIGHTGRAY})
TERM_BG_DARKGRAY=$(tput setab ${TERM_COLOR_DARKGRAY})

# Helper for printing ANSI escape codes to stdout/stdett
escape-ansi-colors() {
    sed "s/\x1b/^[/g"
}

# Make colorized man pages interact better with `env`
man() {
    LESS_TERMCAP_mb="${TERM_BOLD}${TERM_FG_CYAN}" \
    LESS_TERMCAP_md="${TERM_BOLD}${TERM_FG_CYAN}" \
    LESS_TERMCAP_me="${TERM_RESET}" \
    LESS_TERMCAP_se="${TERM_RESET}" \
    LESS_TERMCAP_ue="${TERM_RESET}" \
    LESS_TERMCAP_us="${TERM_BOLD}${TERM_FG_YELLOW}" \
    LESS_TERMCAP_so="${TERM_BOLD}${TERM_FG_WHITE}${TERM_BG_BLUE}" \
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
