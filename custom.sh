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

##
## zaw
##
## Note: http://blog.patshead.com/2013/04/more-powerful-zsh-history-search-using-zaw.html
source $ZSH_PWD/zaw/zaw.zsh

bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search

bindkey -M filterselect '^[^H' backward-delete-word # urxvt:   Alt+BackSpace

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey -M filterselect "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey -M filterselect "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey -M filterselect "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey -M filterselect "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]]  && bindkey -M filterselect "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey -M filterselect "${key[PageDown]}" history-beginning-search-forward

zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select' max-lines 10
zstyle ':filter-select' case-insensitive yes
# zstyle ':filter-select' extended-search yes
## End 'zaw' configutation

# zsh-syntax-highlighting
source $ZSH_PWD/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
