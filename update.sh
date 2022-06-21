#!/bin/sh

# Pull the latest changes and update submodules
git pull && git submodule update --init --recursive --remote

ROOT=$(pwd)

# Update powerlevel10k.
cd "${ROOT}/oh-my-zsh/custom/themes/powerlevel10k" && git pull

# Update zsh-autosuggestions.
cd "${ROOT}/oh-my-zsh/custom/plugins/zsh-autosuggestions" && git pull

