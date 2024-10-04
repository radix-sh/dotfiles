export ZSH="$HOME/.oh-my-zsh"

# Preferences
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ENABLE_CORRECTION="true"
HYPHEN_INSENSITIVE="true"
ZSH_THEME="agnoster"    # or: arrow, duellj, headline, powerline
DEFAULT_USER="radix"

plugins=(
  git
  dotenv
)

# For uv (Python package manager for ECS 170)
. "$HOME/.cargo/env"

# https://stackoverflow.com/questions/62931101/i-have-multiple-files-of-zcompdump-why-do-i-have-multiple-files-of-these
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
