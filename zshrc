ZSH_PWD=${MY_PATH}

# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH


# zaw
# Note: http://blog.patshead.com/2013/04/more-powerful-zsh-history-search-using-zaw.html
source $ZSH_PWD/zaw/zaw.zsh

bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search

zstyle ':filter-select:highlight' matched fg=green
#zstyle ':filter-select' max-lines 5
zstyle ':filter-select' case-insensitive yes # enable case-insensitive 
zstyle ':filter-select' extended-search yes # see below

