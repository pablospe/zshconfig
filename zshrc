# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Add custom completion scripts
fpath=($ZSH_PWD/zsh-completions/src $fpath)

# Set name of the theme to load.
ZSH_THEME="pablo"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git gitfast git-extras command-not-found last-working-dir web-search dirhistory)

# Load Oh-my-zsh
source $ZSH/oh-my-zsh.sh


# Bindings
source $ZSH_PWD/bindkey.sh

# User customization (setopt, plugins, etc.)
source $ZSH_PWD/custom.sh

# Alias
source $ZSH_PWD/alias.sh

# Export
source $ZSH_PWD/export.sh

