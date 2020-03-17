# Share history between multiple shells
setopt share_history
setopt HIST_IGNORE_ALL_DUPS

# Enter directory without 'cd'
setopt auto_cd

# Needed for dircycle implementation (see alias.sh)
setopt autopushd pushdsilent pushdtohome

# Remove duplicate entries
setopt pushdignoredups

# This reverts the +/- operators.
setopt pushdminus

# Load incremental autocomplete
#source $ZSH_PWD/incr-autocomplete/load.sh

##
## zaw
##
## Note: http://blog.patshead.com/2013/04/more-powerful-zsh-history-search-using-zaw.html
source $ZSH_PWD/zaw/zaw.zsh

bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search
bindkey -M filterselect '' accept-search
bindkey -M filterselect '^[' send-break

bindkey -M filterselect '^I'   down-line-or-history  # TAB
bindkey -M filterselect '[Z' up-line-or-history    # Shift+TAB

bindkey -M filterselect '^[^H' backward-delete-word  # urxvt: Alt+BackSpace
bindkey -M filterselect '^H'   backward-delete-word  # urxvt: C-BS

bindkey -M filterselect '^[^?' backward-delete-word  # konsole: Alt+BackSpace

bindkey -M filterselect '^D'   send-break              # c-d


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

##
## fasd - https://github.com/clvv/fasd
##
## Note: the oh-my-zsh has been copy here because it has to be loaded
##       after the incremental autocomplete
##
export PATH=$ZSH_PWD/fasd:$PATH

if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="$HOME/.fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
  alias v='f -e vim'
fi

bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ${ZSH_PWD}/fzf/zsh-interactive-cd.plugin.zsh
source ${ZSH_PWD}/fzf/forgit.plugin.zsh

