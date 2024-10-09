# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Add custom completion scripts
fpath=($ZSH_PWD/zsh-completions/src $fpath)

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
  bazel
  command-not-found
  docker
  docker-compose
  extract
  fasd
  fzf-tab
  gh
  git
  git-extras
  git-flow
  last-working-dir
  pip
  pylint
  rsync
  tig
  tmux
  web-search
  zsh-autosuggestions
)

# Load Oh-my-zsh
zstyle ':omz:update' mode disabled
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

# OSC support
# https://wezfurlong.org/wezterm/config/lua/keyassignment/ScrollToPrompt.html#scrolltoprompt
# https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md#zsh-shell
source $ZSH_PWD/OSC-shell-integration.zsh