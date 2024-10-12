# Path to your oh-my-zsh configuration.
export ZSH=$ZSH_PWD/oh-my-zsh

# Add custom completion scripts
fpath=($ZSH_PWD/zsh-completions/src $fpath)

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="pablo"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Check if the parent process is 'mc' (Midnight Commander)
# https://bbs.archlinux.org/viewtopic.php?id=279096
if [[ $(realpath /proc/$PPID/exe) == */mc ]]; then
  # Running inside Midnight Commander
  # typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

  # Plugins
  plugins=(
    bazel
    command-not-found
    docker
    docker-compose
    extract
    # fasd
    fzf-tab
    # git
    # git-extras
    last-working-dir
    zsh-autosuggestions
  )
else
  # Plugins
  plugins=(
    bazel
    command-not-found
    docker
    docker-compose
    extract
    fasd
    fzf-tab
    git
    git-extras
    last-working-dir
    zsh-autosuggestions
  )

  # OSC support
  source $ZSH_PWD/wezterm.sh
fi

# Load Oh-my-zsh
zstyle ':omz:update' mode disabled
source $ZSH/oh-my-zsh.sh

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
