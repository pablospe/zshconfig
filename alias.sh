# Folders
alias cd..="cd .."
alias cd -="popd"
alias ....="cd ../../.."
alias lsdirs='ls --color -d */'

# Less (opensuse alias)
alias o="less"

# du and df
alias du="du -h --max-depth=1"
alias df="clear; df -h"

# find
alias f="noglob ~/bin/find.sh"
alias f_i="noglob ~/bin/find_i.sh"
alias ff="find . -name"

# Untar
alias untar="tar -xvf"

# Open file
alias op="xdg-open"

# User shorcuts
alias doc="cd ~/Documents"
alias des="cd ~/Downloads"
alias D="cd ~/Desktop/"
alias a="cd ~/Documents/Anotaciones"
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

# Others
alias alarma="aplay /home/spe/Documents/Sound/finish.wav"
alias mensaje="notify-send --urgency=critical --expire-time=0 \"ATENCIÓN\" \"Terminó!\" --icon=/usr/share/icons/gnome/32x32/status/important.png"
alias open_microphone="arecord -f cd -D hw:0,0  | aplay"
alias temp="cat /proc/acpi/thermal_zone/THM/temperature"
alias LOG="svn log -r 0:HEAD | less"

