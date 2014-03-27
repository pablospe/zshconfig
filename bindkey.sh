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
## Dircycle
##
## A modification of the dircycle plugin: enables cycling through the directory
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

# Alt+Down
# bindkey "^[[1;3B" reverse-menu-complete

# Alt+Up is "cd .."
function cd-up () { zle push-line; LBUFFER='cd ..'; zle accept-line }
zle -N cd-up
bindkey "^[[1;3A" cd-up # konsole
bindkey "^[[Á"    cd-up # urxvt


# Alt+BackSpace delete (big) word. Note: it is different than Ctrl+W
function backwards-delete-part () {
  local sep=" :"
  LBUFFER=${(M)${LBUFFER%[$sep]}##*[$sep]}
}
zle -N backwards-delete-part

bindkey "^[^?" backwards-delete-part # konsole: Alt+BackSpace
bindkey '^[^H' backwards-delete-part # urxvt:   Alt+BackSpace
bindkey '^H'   backwards-delete-part # C-H

bindkey "^[[3^" delete-word  # urxvt: C-delete
bindkey "^[[3"  delete-word  # urxvt: Alt-delete

bindkey '^[Od' backward-word # urxvt: C-Left
bindkey '^[Oc' forward-word  # urxvt: C-Right

# Map Ctrl-S to something usefull other than XOFF (interrupt data flow)
stty -ixon

