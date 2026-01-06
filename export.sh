# ssh -- 256 colors
# http://stackoverflow.com/questions/6787734/strange-behavior-of-vim-color-inside-screen-with-256-colors
# try: https://raw.githubusercontent.com/incitat/eran-dotfiles/master/bin/terminalcolors.py
export TERM=xterm-256color
case "$TERM" in
*-256color)
    alias ssh='TERM=${TERM%-256color} ssh'
    ;;
*)
    POTENTIAL_TERM=${TERM}-256color
    POTENTIAL_TERMINFO=${TERM:0:1}/$POTENTIAL_TERM

    # better to check $(toe -a | awk '{print $1}') maybe?
    BOX_TERMINFO_DIR=/usr/share/terminfo
    [[ -f $BOX_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
        export TERM=$POTENTIAL_TERM

    HOME_TERMINFO_DIR=$HOME/.terminfo
    [[ -f $HOME_TERMINFO_DIR/$POTENTIAL_TERMINFO ]] && \
        export TERM=$POTENTIAL_TERM
    ;;
esac

# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Go binaries
export PATH="$PATH:$HOME/go/bin"

# Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# export grep settings
alias grep="grep $GREP_OPTIONS"

# clean up
unset GREP_OPTIONS

# http://cwrapper.sourceforge.net/
# Note: before 'colorgcc'
# export PATH=/usr/local/lib/cw:$PATH

##
## colorgcc
##
# sudo apt-get install colorgcc
# sudo mkdir -p /usr/lib/colorgcc/
# cd /usr/lib/colorgcc/
# sudo ln -s /usr/bin/colorgcc gcc
# sudo ln -s /usr/bin/colorgcc g++
# sudo ln -s /usr/bin/colorgcc cc
# sudo ln -s /usr/bin/colorgcc c++
##
export PATH=/usr/lib/colorgcc:$PATH

# Color for less (manpages)
export LESS_TERMCAP_md=$'\e[01;34m';
export LESS_TERMCAP_us=$'\e[01;31m';
export LESS_TERMCAP_so=$'\e[01;32m';
export LESS_TERMCAP_ue=$'\e[00;00m';
export LESS_TERMCAP_se=$'\e[00;00m';
# export LESS_TERMCAP_me=$'\e[00;00m';
# export LESS_TERMCAP_mb=$'\e[00;00m';

# ccache is a compiler cache. It speeds up recompilation by caching previous
# compilations and detecting when the same compilation is being done again
#export PATH=/usr/lib/ccache:$PATH
