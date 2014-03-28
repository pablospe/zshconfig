# Share history between multiple shells
setopt share_history
setopt HIST_IGNORE_ALL_DUPS

# Needed for dircycle implementation (see alias.sh)
setopt autopushd pushdsilent pushdtohome

# Remove duplicate entries
setopt pushdignoredups

# This reverts the +/- operators.
setopt pushdminus

# Load incremental autocomplete
source $ZSH_PWD/incr-autocomplete/load.sh

## zaw
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
