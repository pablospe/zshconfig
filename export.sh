# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# http://cwrapper.sourceforge.net/
# Note: before 'colorgcc'
# export PATH=/usr/local/lib/cw:$PATH

##
## colorgcc
##
# sudo apt-get install colorgcc
# sudo mkdir -p /usr/lib/colorgcc/
# sudo ln -s /usr/bin/colorgcc gcc
# sudo ln -s /usr/bin/colorgcc g++
# sudo ln -s /usr/bin/colorgcc cc
# sudo ln -s /usr/bin/colorgcc c+
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
