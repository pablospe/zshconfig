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


# Setup zsh-autosuggestions
source $ZSH_PWD/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle

# Accept suggestions without leaving insert mode
bindkey '^f' vi-forward-word
