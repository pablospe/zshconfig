# Folders
alias cd..="cd .."
alias cd -="popd"
alias ....="cd ../../.."
alias lsdirs='ls --color -d */'

# Uses ls++ if exists
# Note: ttps://github.com/pablospe/ls--
if hash ls++ 2>/dev/null; then
  alias l="ls++ --ptsf"
  alias ll="ls++ -a --potsf"
fi

# https://github.com/trapd00r/LS_COLORS
eval $(dircolors -b $ZSH_PWD/ls_colors/LS_COLORS)

# Using Vim as Pager
alias vless='/usr/share/vim/vim74/macros/less.sh'
alias oo="vless"  # 'o' was the alias but used by fasd

# du
alias du="du -h --max-depth=1"

# Colorized du: http://arsunik.free.fr/prog/cdu.html
alias cdu="cdu -i -s -dh"

# dfc (sudo apt-get install dfc)
alias df="dfc -f"

# Colorized cat (sudo apt-get install python-pygments)
alias ccat='pygmentize -O style=monokai -f console256 -g'

# find
function find_i {
  echo "Searching:" \""$@"\"" ... "
  find . -iname "*$@*" | grep -i "$@"
}
alias ff="find_i"

# Untar
alias untar="tar -xvf"

# Open file
alias op="xdg-open"

# User shorcuts
alias doc="cd ~/Documents"
alias des="cd ~/Downloads"
alias D="cd ~/Desktop/"
alias W="cd ~/wrk"
alias kk="cd ~/kk"

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

# mkdir and enter
function mkdircd () {
  mkdir $1; cd $1
}

# Download accelerator (like 'wget' but in parallel)
alias axel="axel -a"

# PWD (and copy to clipboard)
alias pw="pwd | tr -d '\n' | xclip -selection 'clipboard'; pwd"

# Ping
alias ping="ping -c 3"

# Meld
alias m.="meld ."

# Others
alias cal="cal -3"
alias free="free -m"
alias alarma="aplay /home/spe/Documents/Sound/finish.wav"
alias mensaje="notify-send --urgency=critical --expire-time=0 \"ATENCIÓN\" \"Terminó!\" --icon=/usr/share/icons/gnome/32x32/status/important.png"
alias open_microphone="arecord -f cd -D hw:0,0  | aplay"
alias temp="cat /proc/acpi/thermal_zone/THM/temperature"
alias LOG="svn log -r 0:HEAD | less"

# gss: git status alias
# Note: colors same as in the prompt
alias gss="__gss"

__gss() {
  INDEX=$(git status --porcelain -b 2>/dev/null)

  # Split git status in categories
  GIT_STAGED=$(echo $INDEX | grep -E '^A |^M ')
  GIT_MODIFIED=$(echo $INDEX | grep -E '^ M |^AM |^ T |^MM ')
  GIT_DELETED=$(echo $INDEX | grep -E '^ D |^D  |^AD ')
  GIT_RENAMED=$(echo $INDEX | grep '^R  ' )
  GIT_UNMERGED=$(echo $INDEX | grep '^UU ')
  GIT_UNTRACKED=$(echo $INDEX | grep -E '^\?\? ')

  # Print categories with different color and symbols
  __git_print_status ● $fg_bold[cyan]    "Staged changes"  $GIT_STAGED
  __git_print_status ✚ $fg_bold[yellow]  "Modified files"  $GIT_MODIFIED
  __git_print_status ✖ $fg_bold[red]     "Deleted files"   $GIT_DELETED
  __git_print_status ➜ $fg_bold[magenta] "Renamed files"   $GIT_RENAMED
  __git_print_status ═ $fg_bold[yellow]  "Unmerged files"  $GIT_UNMERGED
  __git_print_status … $fg[red]          "Untracked files" $GIT_UNTRACKED
}

__git_print_status() {
  str=$4
  if [[ -n $str ]]; then
    symbol=$1
    color=$2
    echo -n ${color}
    echo $3:
    # Getting last column and adding symbol at the beginning
    echo $str | sed -e 's/^.* //' | sed "s/^/\t\t${symbol} /"
    echo -n $reset_color
  fi
}
