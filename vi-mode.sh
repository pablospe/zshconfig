##
## Vi mode
##

bindkey -v

# 10ms for key sequences. Default is 0.4 seconds
KEYTIMEOUT=1

# Disable all keybindings that rely on ESC as a prefix
#bindkey -rpM viins '^['


# If set to `yes', make viins mode behave more like `emacs' mode. Bindings
# such as `^r' and `^s' will work. Backspace and `^w' will work more like
# emacs would, too.
zle_ins_more_like_emacs='yes'

if [[ ${zle_ins_more_like_emacs} == 'yes' ]]; then
  bindkey -M viins -M vicmd '^K' kill-line
  bindkey -M viins -M vicmd '^U' kill-whole-line
  bindkey -M viins -M vicmd '^p' up-line-or-history

#   bindkey '/' history-incremental-pattern-search-backward

  # jkl; alternative.
  # http://stackoverflow.com/questions/6698521/vim-users-where-do-you-rest-your-right-hand/15330610#15330610
  bindkey -M vicmd 'l' backward-char
  bindkey -M vicmd ';' forward-char

  # Hack to act 'alt+.' as insert-last-word (needs map in .Xresources)
  bindkey -M viins '\e.' insert-last-word
  bindkey -M vicmd '\e.' insert-last-word

  # setup key accordingly
  [[ -n "${key[Home]}"     ]]  && bindkey -M viins -M vicmd "${key[Home]}"     beginning-of-line
  [[ -n "${key[End]}"      ]]  && bindkey -M viins -M vicmd "${key[End]}"      end-of-line
  [[ -n "${key[Insert]}"   ]]  && bindkey -M viins -M vicmd "${key[Insert]}"   overwrite-mode
  [[ -n "${key[Delete]}"   ]]  && bindkey -M viins -M vicmd "${key[Delete]}"   delete-char
  [[ -n "${key[PageUp]}"   ]]  && bindkey -M viins -M vicmd "${key[PageUp]}"   history-beginning-search-backward
  [[ -n "${key[PageDown]}" ]]  && bindkey -M viins -M vicmd "${key[PageDown]}" history-beginning-search-forward
  [[ -n "${key[Left]}"     ]]  && bindkey -M viins -M vicmd "${key[Left]}"     backward-char
  [[ -n "${key[Right]}"    ]]  && bindkey -M viins -M vicmd "${key[Right]}"    forward-char

  # Shift+Tab
  bindkey -M viins -M vicmd "\e[Z" expand-word # Note: Ctrl+'_' for undo

  # Alt+Up is "cd .."
  function cd-up () { zle push-line; LBUFFER='cd ..'; zle accept-line }
  zle -N cd-up
  bindkey -M viins -M vicmd "^[[1;3A"  cd-up # konsole
  bindkey -M viins -M vicmd "^[[Ã" cd-up # urxvt


  # Alt+BackSpace delete (big) word. Note: it is different than Ctrl+W
  function backwards-delete-part () {
    local sep=" :"
    LBUFFER=${(M)${LBUFFER%[$sep]}##*[$sep]}
  }
  zle -N backwards-delete-part

  bindkey -M viins -M vicmd '^?'   backward-delete-char  # urxvt:   BS
  bindkey -M viins -M vicmd '^H'   backwards-delete-part # urxvt:   C-BS
  bindkey -M viins -M vicmd '^[^H' backwards-delete-part # urxvt:   Alt-BS

  bindkey -M viins -M vicmd "^[[3^" delete-word  # urxvt: C-delete
  bindkey -M viins -M vicmd "^[[3"  delete-word  # urxvt: Alt-delete

  bindkey -M viins '^[[1;5D' backward-word # urxvt: C-Left
  bindkey -M viins '^[[1;5C' forward-word  # urxvt: C-Right

  bindkey -M vicmd "^[[3^" delete-word     # urxvt: C-delete
  bindkey -M vicmd "^[[3"  delete-word     # urxvt: Alt-delete

  bindkey -M viins -M vicmd "^[[1;3D" dirhistory_zle_dirhistory_back   # urxvt: Alt+Left
  bindkey -M viins -M vicmd "[1;3C" dirhistory_zle_dirhistory_future # urxvt: Alt+Right (not working)

  bindkey -M viins -M vicmd "^F" forward-word  # C-f

  # Ctrl+P and Ctrl+N
  bindkey -M viins -M vicmd "" history-beginning-search-backward
  bindkey -M viins -M vicmd "" history-beginning-search-forward
fi


## Show vi mode: [INS] or [CMD]
## http://superuser.com/questions/151803/how-do-i-customize-zshs-vim-mode/156204#156204
#vim_ins_mode="%{$fg_bold[black]%}[INS]%{$reset_color%} ${RPS1}"
vim_ins_mode="${RPS1}"
vim_cmd_mode="%{$fg_bold[green]%}[CMD]%{$reset_color%} ${RPS1}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode="$vim_ins_mode"
}
zle -N zle-line-finish

RPROMPT='${vim_mode}'
