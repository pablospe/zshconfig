# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Add custom completion scripts
fpath=($ZSH_PWD/zsh-completions/src $fpath)

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git git-extras git-flow fasd command-not-found web-search last-working-dir pylint extract docker docker-compose)

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ROS
#source /opt/ros/<distro>/setup.zsh
#export ROS_MASTER_URI=http://192.168.0.100:11311
#source ~/catkin_ws/devel/setup.zsh

# Bindings
source $ZSH_PWD/bindkey.sh

# Vi mode
#source $ZSH_PWD/vi-mode.sh

# User customization (setopt, plugins, etc.)
source $ZSH_PWD/custom.sh

# Alias
source $ZSH_PWD/alias.sh

# Export
source $ZSH_PWD/export.sh

# Load gss (git status)
source $ZSH_PWD/gss.sh
