##
## Bindings
##
## Note: http://zshwiki.org/home/zle/bindkeys
##

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
#   echo 'Loding setup keys using zkbd file:' $keyfile
  source "${keyfile}"
else
  echo 'Failed to setup keys using zkbd.'
fi
unfunction zkbd_file; unset keyfile ret

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
bindkey "" history-beginning-search-backward
bindkey "" history-beginning-search-forward


# Enable keybindings that use the Alt key (not working for urxvt)
# bindkey -m

# Alt+s or ESC, s: inserts "sudo " at the start of line:
function insert-sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo
bindkey "^[s" insert-sudo

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

# Map Ctrl-S to something usefull other than XOFF (interrupt data flow)
stty -ixon

