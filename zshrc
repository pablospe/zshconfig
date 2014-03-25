# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# zsh-syntax-highlighting
source zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


