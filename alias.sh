# Folders
alias cd..="cd .."
alias cd -="popd"
alias ....="cd ../../.."
alias lsdirs='ls --color -d */'

# A modern replacement for ‘ls’.
#
#    https://github.com/ogham/exa
#
# '-s size' (for sorting by size)
#
# Note: for icons to work properly it needs one of the Nerd fonts.
#
if hash eza 2>/dev/null; then
  alias l="eza -l --group-directories-first --color=always --icons --hyperlink --smart-group --time-style=relative"
  alias ll="eza -l --group-directories-first --color=always -a --icons --hyperlink"
  alias ls="eza --group-directories-first --color=always --hyperlink --smart-group"
  alias lr="eza -l --group-directories-first --color=always --icons --hyperlink --smart-group --time-style=relative --tree"
  alias tree="eza --group-directories-first --color=always --icons --hyperlink --smart-group --time-style=relative --tree"
elif hash exa 2>/dev/null; then
  alias l="exa -l --group-directories-first --color-scale --color=always"
  alias ll="exa -l --group-directories-first --color-scale --color=always -a --icons"
  alias ls="exa --group-directories-first --color-scale --color=always"
else
  alias l="ls -lh --group-directories-first --hyperlink=always"
  alias ll="ls -lah --group-directories-first --hyperlink=always"
fi
alias la="l -a"

# https://github.com/trapd00r/LS_COLORS
eval $(dircolors -b $ZSH_PWD/ls_colors/LS_COLORS)


# Uses bat if exists (installed as batcat on Debian/Ubuntu)
if hash bat 2>/dev/null; then
    alias o="bat"
elif hash batcat 2>/dev/null; then
    alias bat="batcat"
    alias o="batcat"
else
    alias o="less"
fi

#git
alias gw='git worktree'
alias gwa='git worktree add'
alias gwls='git worktree list'
alias gwrm='git worktree remove'

# worktrunk
alias wts='wt switch'
alias wtsc='wt switch --create'
alias wtl='wt list'

# claude code (shadows the C compiler `cc` in interactive shells).
# Continues the last session in $PWD, or starts a new one if there is none.
unalias cc 2>/dev/null
function cc {
  local sessions=(~/.claude/projects/${PWD//[^a-zA-Z0-9]/-}/*.jsonl(N))
  if (( ${#sessions} )); then
    claude --dangerously-skip-permissions --continue "$@"
  else
    claude --dangerously-skip-permissions "$@"
  fi
}

# micro editor.
# curl https://getmic.ro | bash
alias m="micro"

# mdterm (terminal markdown renderer); overrides oh-my-zsh's md='mkdir -p'.
alias md="mdterm"

# du
alias du="du -h --max-depth=1"
if hash ncdu 2>/dev/null; then
  alias du="ncdu"
fi

# dfc (sudo apt-get install dfc)
if hash dfc 2>/dev/null; then
  alias df="dfc -f -T -q "name" -t ext,fuse"
fi

# find
function find_i {
  find . -iname "*$@*" | grep -i "$@"
}
alias ff="find_i"
alias f="find_i"

# Untar
alias untar="tar -xvf"

# Open file
alias op="xdg-open"

# User shorcuts
alias doc="cd ~/Documents"
alias des="cd ~/Downloads"
alias D="cd ~/Desktop/"
alias W="cd ~/wrk"

# 'which' shortcut (it will copy the result to clipboard)
# Example: 'w grep'
function w() {
  which "$@" | tr -d '\n' | xclip -selection 'clipboard'; which "$@"
}

# 'ps' shortcut
# Example: 'p X'
function p() {
  ps aux | head -1
  ps aux | grep -v grep | grep "$@"
}

# ps (forest)
alias ps='ps f'

function cp_rsync () {
  echo rsync -avh --progress $1 $2
  rsync -avh --progress $1 $2
}

# Download accelerator (like 'wget' but in parallel)
alias axel="axel -a"

# PWD (and copy to clipboard)
alias pw="pwd | tr -d '\n' | xsel -ib; pwd"

# Ping
alias ping="ping -c 3"

# Catkin
alias cm="catkin_make"

# p10k
alias p10k_icons="source ~/.p10k.zsh"
alias p10k_noicons="source ~/.p10k-noicons.zsh"

# fasd
alias z='fasd_cd -d'

# tmux (overwrite oh-my-zsh plugin alias)
alias ta='tmux attach'

# tn [name]: new tmux session (default name: current dir) with a `main` window
# running claude (`cc`) on top and a shell below. Reuses the session if it exists.
function tn {
  local name=${1:-${PWD:t}}
  name=${name//[.:]/_}
  if ! tmux has-session -t "=$name" 2>/dev/null; then
    local top=$(tmux new-session -d -P -F '#{pane_id}' -s "$name" -n main -c "$PWD")
    tmux split-window -v -t "$top" -c "$PWD"
    tmux send-keys -t "$top" cc Enter
    tmux select-pane -t "$top"
  fi
  if [[ -n $TMUX ]]; then
    tmux switch-client -t "=$name"
  elif [[ -n $KONSOLE_DBUS_SESSION ]] && hash qdbus 2>/dev/null; then
    # Name the Konsole tab after the session while attached, restore on detach.
    local k=(qdbus $KONSOLE_DBUS_SERVICE $KONSOLE_DBUS_SESSION)
    local fmt0=$($k tabTitleFormat 0) fmt1=$($k tabTitleFormat 1)
    $k setTabTitleFormat 0 "$name"; $k setTabTitleFormat 1 "$name"
    tmux attach -t "=$name"
    $k setTabTitleFormat 0 "$fmt0" 2>/dev/null; $k setTabTitleFormat 1 "$fmt1" 2>/dev/null
  else
    tmux attach -t "=$name"
  fi
}

# tig: with no args, select the latest commit instead of the untracked/unstaged/staged
# rows above it (one row each, only when there is something to show).
function tig {
  if (( $# == 0 )) && git rev-parse --is-inside-work-tree &>/dev/null; then
    local line=1
    git diff --cached --quiet 2>/dev/null || (( line++ ))
    git diff --quiet 2>/dev/null || (( line++ ))
    [[ -n $(git ls-files -o --exclude-standard 2>/dev/null | head -1) ]] && (( line++ ))
    command tig +$line
  else
    command tig "$@"
  fi
}

# copilot
alias e="gh copilot explain"
alias copilot="gh copilot explain"

# Use neovim if available
if hash nvim 2>/dev/null; then
    alias vi="nvim"
    alias vim="nvim"
fi

# Others
alias free="free -m"
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
