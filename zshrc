# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git)

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Load incremental autocomplete
source $ZSH_PWD/incr-autocomplete/load.sh
