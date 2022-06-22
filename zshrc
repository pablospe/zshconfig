# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Add custom completion scripts
fpath=($ZSH_PWD/zsh-completions/src $fpath)

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(command-not-found docker docker-compose extract fasd fd git git-extras git-flow last-working-dir pylint rsync tmux web-search zsh-autosuggestions)

# Load zsh-autocomplete
source $ZSH_PWD/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zstyle ':autocomplete:*' recent-dirs fasd

# https://github.com/marlonrichert/zsh-autocomplete/issues/249
zstyle ':completion:*:' tag-order '! ancestor-directories recent-directories recent-files' -
zstyle ':autocomplete:*' min-input 1

zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:tab:*' insert-unambiguous yes

# Down arrow:
bindkey '\e[B' down-line-or-select
bindkey '\eOB' down-line-or-select

# Uncomment the following lines to disable live history search:
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward



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
