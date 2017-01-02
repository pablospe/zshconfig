# Folders
alias cd..="cd .."
alias cd -="popd"
alias ....="cd ../../.."
alias lsdirs='ls --color -d */'

# Uses ls++ if exists
# Note: https://github.com/pablospe/ls--
if hash ls++ 2>/dev/null; then
  alias l="ls++ --ptsf"
  alias ll="ls++ -a --potsf"
fi

# https://github.com/trapd00r/LS_COLORS
eval $(dircolors -b $ZSH_PWD/ls_colors/LS_COLORS)

# Using Vim as Pager
alias vless='/usr/share/vim/vim74/macros/less.sh'
alias oo="vless"  # 'o' was the alias but used by fasd
alias o="less"

# du
alias du="du -h --max-depth=1"

# Colorized du: http://arsunik.free.fr/prog/cdu.html
alias cdu="cdu -i -s -dh"

# dfc (sudo apt-get install dfc)
if hash dfc 2>/dev/null; then
  alias df="dfc -f"
fi

# Colorized cat (sudo apt-get install python-pygments)
alias ccat='pygmentize -O style=monokai -f console256 -g'

# find
function find_i {
  find . -iname "*$@*" | grep -i "$@"
}
alias ff="find_i"
alias f="find_i"

# Fixing  'v', fasd alias
alias v='fasd -e vim'

# Untar
alias untar="tar -xvf"

# Open file
alias op="xdg-open"

# User shorcuts
alias doc="cd ~/Documents"
alias des="cd ~/Downloads"
alias D="cd ~/Desktop/"
alias W="cd ~/wrk"
alias kk="cd /tmp"

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

# Meld
alias m.="meld ."

# Catkin
alias cm="catkin_make"

# Others
alias free="free -m"
alias alarma="aplay /home/spe/Documents/Sound/finish.wav"
alias mensaje="notify-send --urgency=critical --expire-time=0 \"ATENCIÓN\" \"Terminó!\" --icon=/usr/share/icons/gnome/32x32/status/important.png"
alias open_microphone="arecord -f cd -D hw:0,0  | aplay"
alias temp="cat /proc/acpi/thermal_zone/THM/temperature"
alias LOG="svn log -l 10 -r HEAD:1 | less"
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

function get_build_folder_name() {
    # default folder for compilation
    BUILDS="$HOME/build"

    # pwd
    CURRENT_DIR=`pwd | sed 's/ /_/g'`  # replace space by '_'
    BASE=`basename $CURRENT_DIR`

    # echo $1
    NAME=$1
    if [ -z "$NAME" ]; then
        NAME="build"
    fi
    FOLDER=$BUILDS/${BASE}_${NAME}
}

# separe "build/" directory from the actually "wrk/" folder
function mkbuild() {
    get_build_folder_name $1

    # create folder
    printf "Creating folder in: \n\t%s\n\n" $FOLDER
    if [ -d "$FOLDER" ]
    then
        printf "Directory already exists! Solution:\n"
        printf "\trm -r $FOLDER\n\n"
        return 1
    fi
    mkdir -p $FOLDER

#     # create symbolic link
#     if [ -d "$NAME" ]
#     then
#         printf "Symbolic link already exists! Solution:\n"
#         printf "\trm -r $NAME\n\n"
#         return 1
#     fi
#     ln -s $FOLDER $NAME
#     ls -l $NAME
#     echo ""

    cd $FOLDER
    echo cmake $CURRENT_DIR -DCMAKE_INSTALL_PREFIX="$HOME/install/${BASE}_${NAME}"
    cmake $CURRENT_DIR -DCMAKE_INSTALL_PREFIX="$HOME/install/${BASE}_${NAME}"
}

function rmbuild() {
    get_build_folder_name $1
    echo rm -rf $FOLDER
    rm -rf $FOLDER
}

function cdbuild() {
    get_build_folder_name $1
    echo $FOLDER
    cd $FOLDER
}
