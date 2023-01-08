# Prompt
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
RED="\[\033[0;31m\]"
PURPLE="\[\033[0;35m\]"
BROWN="\[\033[0;33m\]"
BRIGHT_GRAY="\[\033[0;37m\]"
BRIGHT_BLUE="\[\033[1;34m\]"
BRIGHT_GREEN="\[\033[1;32m\]"
BRIGHT_CYAN="\[\033[1;36m\]"
BRIGHT_RED="\[\033[1;31m\]"
BRIGHT_PURPLE="\[\033[1;35m\]"
YELLOW="\[\033[1;33m\]"
WHITE="\[\033[1;37m\]"
RESTORE="\[\033[0m\]"
# MacOS
if [[ $OSTYPE == 'darwin'* ]]; then
    export PS1="${GREEN}\w${BRIGHT_BLUE}\$(parse_git_branch)${RESTORE} 🌈 "
    echo $OSTYPE
# WSL
else if grep -qi "microsoft" /proc/version; then
    export PS1="${BRIGHT_PURPLE}\w${CYAN}\$(parse_git_branch)${RESTORE} $ "
    alias open='explorer.exe'
fi
fi

# Basic config
CC="/usr/local/bin/gcc-10"
CLICOLOR=1
CXX="/usr/local/bin/g++-10"
EDITOR="/usr/local/bin/vim"
LSCOLORS="gxcxBxDxexxxxxaBxBhghGh"
export CC CLICOLOR CXX EDITOR LSCOLORS 

# Bash settings
BASH_SILENCE_DEPRECATION_WARNING=1
HISTCONTROL=erasedups
HISTFILESIZE=
HISTSIZE=
export HISTCONTROL HISTFILESIZE HISTSIZE BASH_SILENCE_DEPRECATION_WARNING

# Make path
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin/:$PATH"
PATH=$PATH:$HOME/Library/Python/3.9/bin/
export PATH=$PATH:$HOME/bin

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Functions
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function mkcd() {
    mkdir "$1" && cd "$1"
}

# Aliases
alias p='python3'
alias c='gcc -g -Wall -Werror'
alias killgdb='pkill -9 gdb'
alias g='gdb -tty=$(tty)'
alias gauto='gdb -tty=$(tty) --command=auto.gdb'
alias brewup='brew update && brew upgrade; brew cleanup; brew doctor'
alias l='ls'
alias la='ls -a'
alias lt='ls -lt'
alias 'lg'='git log --color --graph --pretty --abbrev-commit'

# To fix gpg failed to sign data error:
# https://stackoverflow.com/questions/41052538/git-error-gpg-failed-to-sign-data
gpgconf --kill gpg-agent

# Make pinentry work for unlocking GPG keys
export GPG_TTY=$(tty)
