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


# zsh-history-substring-search
source $ZSH_PWD/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


