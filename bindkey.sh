##
## Bindings
##

#
# zkbd - special keys solution
#
# If you use several different terminal emulators, it's likely,
# that you've run into the problem, that pressing a special key
# like PageDown will just display a tilde instead of doing what
# it's supposed to.
#
# There is a function described in zshcontrib(1) that reads and
# stores keydefinitions for special keys, if it recognizes a terminal
#
# Link: http://zshwiki.org/home/zle/bindkeys
#

use_zkbd='no'

if [[ ${use_zkbd} == 'yes' ]]; then
  autoload zkbd
  function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
  }

  [[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
  keyfile=$(zkbd_file)
  ret=$?
  if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
  fi
  if [[ ${ret} -eq 0 ]] ; then
    #echo 'Loding setup keys using zkbd file:' $keyfile
    source "${keyfile}"
  else
    echo 'Failed to setup keys using zkbd.'
  fi
  unfunction zkbd_file; unset keyfile ret
fi

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]]  && bindkey "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey "${key[PageDown]}" history-beginning-search-forward
[[ -n "${key[Left]}"     ]]  && bindkey "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey "${key[Right]}"    forward-char

[[ -n "${key[Up]}"       ]]  && bindkey "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey "${key[Down]}"     down-line-or-history
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history

# Ctrl+P and Ctrl+N
function history-search-end {
  integer ocursor=$CURSOR
  if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
    # Last widget called set $hbs_pos.
    CURSOR=$hbs_pos
  else
    hbs_pos=$CURSOR
  fi

  if zle .${WIDGET%-end}; then
    # success, go to end of line
    zle .end-of-line
  else
    # failure, restore position
    CURSOR=$ocursor
    return 1
  fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

# Enable keybindings that use the Alt key (not working for urxvt)
# bindkey -m

# Alt+s or ESC, s: inserts "sudo " at the start of line:
function sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line
}
zle -N sudo-command-line
bindkey "^[s" sudo-command-line

# Shift+Tab
bindkey "\e[Z" expand-word # Note: Ctrl+'_' for undo

# Undo
bindkey "^[u" undo # Alt+u or ESC, u

##
## dirhistory
##
## My implementation of the dirhistory plugin, since there are problems
## 'last-working-dir' plugin. It enables cycling through the directory
## stack using Alt+Left/Right
##

# Alt+Left
function insert-cycled-right () { zle push-line; pushd -q ~+0; zle accept-line }
zle -N insert-cycled-right
bindkey "^[[1;3C" insert-cycled-right

# Alt+Right
function insert-cycled-left () { zle push-line; pushd -q -1; zle accept-line }
zle -N insert-cycled-left
bindkey "^[[1;3D" insert-cycled-left

# Alt+Up is "cd .."
function cd-up () { zle push-line; LBUFFER='cd ..'; zle accept-line }
zle -N cd-up
bindkey "^[[1;3A" cd-up # konsole, urxvt
bindkey "^[h" cd-up     # urxvt (ESC h)

# Alt+BackSpace delete (big) word. Note: it is different than Ctrl+W
function backwards-delete-part () {
  local sep=" :"
  LBUFFER=${(M)${LBUFFER%[$sep]}##*[$sep]}
}
zle -N backwards-delete-part

bindkey "^[^?" backwards-delete-part # konsole: Alt+BackSpace
bindkey '^[^H' backwards-delete-part # urxvt:   Alt+BackSpace

bindkey '^H' backward-delete-char   # C-H: Backspace

bindkey "^[[3^" delete-word  # urxvt: C-delete
bindkey "^[[3"  delete-word  # urxvt: Alt-delete

bindkey '^[Od' backward-word # urxvt: C-Left
bindkey '^[Oc' forward-word  # urxvt: C-Right

bindkey "^F" forward-word  # urxvt: C-F
bindkey "^B" backward-word # urxvt: C-B

# Transpose words (between whitespaces)
# Note: 'select-word-style whitespace' didn't work
transpose-words2 () {
  local WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
  zle transpose-words
}
zle -N transpose-words2
bindkey "" transpose-words2 # urxvt: C-T

# home (ESC 0), end (ESC 4). urxvt
# Note: remember 'C-A' and ''C-E'
bindkey "^[0" beginning-of-line
bindkey "^[4" end-of-line

# C-Y: copy line to clipboard
x-yank () {
  echo -n $BUFFER | xclip -selection 'clipboard'
  #echo -n $BUFFER | xsel -i
  #zle yank
}
zle -N x-yank
bindkey -e '^Y' x-yank

# Map Ctrl-S to something usefull other than XOFF (interrupt data flow)
stty -ixon

