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


# Uses bat if exists
if hash bat 2>/dev/null; then
    alias o="bat"
else
    alias o="less"
fi

# micro editor.
# curl https://getmic.ro | bash
alias m="micro"

# du
alias du="du -h --max-depth=1"

# Colorized du: http://arsunik.free.fr/prog/cdu.html
alias cdu="cdu -i -s -dh"

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

# copilot
alias e="gh copilot explain"
alias copilot="gh copilot explain"

# Others
alias free="free -m"
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
