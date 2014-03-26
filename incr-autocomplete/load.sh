# Modified incremental autocomplitation
source $ZSH_PWD/incr-autocomplete/incr*.zsh

# MENU
setopt noautoremoveslash
zmodload zsh/complist
bindkey -M menuselect '^M' .accept-line
zstyle ':completion:*' completer _expand _complete #_approximate
# zstyle ':completion:*:*:*:default' menu yes scroll=0 select=2 interactive 
zstyle ':completion:*:*:default' force-list always
# 
# autoload -U colors
# zstyle -e ':completion:*' list-colors 'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[underline]" )'

