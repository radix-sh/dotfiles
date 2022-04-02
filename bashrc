# prompt
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
if [[ $OSTYPE == 'darwin'* ]]; then
    export PS1="${GREEN}\w${BRIGHT_BLUE}\$(parse_git_branch)${RESTORE} 🌈 "
else
    export PS1="${GREEN}\w${BROWN}${RESTORE} $ "
fi

# basic config
CC="/usr/local/bin/gcc-10"
CLICOLOR=1
CXX="/usr/local/bin/g++-10"
EDITOR="/usr/local/bin/nvim"
LSCOLORS="gxcxBxDxexxxxxaBxBhghGh"
export CC CLICOLOR CXX EDITOR LSCOLORS 

# bash settings
BASH_SILENCE_DEPRECATION_WARNING=1
HISTCONTROL=erasedups
HISTFILESIZE=
HISTSIZE=
export HISTCONTROL HISTFILESIZE HISTSIZE BASH_SILENCE_DEPRECATION_WARNING

# make pinentry work for unlocking GPG keys
export GPG_TTY=$(tty)

# make path
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin/:$PATH"
PATH=$PATH:$HOME/Library/Python/3.9/bin/
export PATH=$PATH:$HOME/bin

if type brew &>/dev/null; then
    for COMPLETION in $(brew --prefix)/etc/bash_completion.d/*
    do
        [[ -f $COMPLETION ]] && source "$COMPLETION"
    done
    if [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]];
    then
        source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi
fi

if [ -f ~/.git-completion.bash ]; then . ~/.git-completion.bash; fi

# bash aliases
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

# bash functions
function mkcd () {
    mkdir "$1" && cd "$1"
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

clear
