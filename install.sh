#!/bin/sh

# Prefix data and color for every command.
PS4='\033[1;31m$(date +%H:%M:%S)\033[0m '
[ ! $(expr "$SHELL" : '.*\(zsh\)$') ] && set -o pipefail

# Pull the latest changes and update submodules
git pull && git submodule update --init --recursive --remote

# Files to be overwritten
FILES='.zshrc .p10k.zsh .p10k-noicons.zsh'

# Create backup
PATH_BACKUP=~/backup/
mkdir -p $PATH_BACKUP

for i in $FILES; do
  [ -f ~/$i ] && mv ~/$i $PATH_BACKUP
done

# Determine my path
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# Source file
cd ${MY_PATH}
ZSHRC="${MY_PATH}/local.sh"

# ZSH_PWD variable inside 'local.sh' (avoiding defaults)
sed -i "3d" $ZSHRC
sed -i "3i\ZSH_PWD=${MY_PATH}" $ZSHRC

# Installing
ln -f -s $ZSHRC ~/.zshrc

# Ignore local changes
git update-index --assume-unchanged $ZSHRC

# Adding 'pablo' theme to oh-my-zsh/theme
ln -f -s $MY_PATH/themes/pablo.zsh-theme $MY_PATH/oh-my-zsh/custom/themes/

# Install zsh-autosuggestions as custom oh-my-zsh plugin.
ln -f -s ${MY_PATH}/zsh-autosuggestions ${MY_PATH}/oh-my-zsh/custom/plugins/zsh-autosuggestions

# Powerlevel10
ln -f -s ${MY_PATH}/powerlevel10k ${MY_PATH}/oh-my-zsh/custom/themes/powerlevel10k
ln -f -s ${MY_PATH}/p10k-noicons.zsh ~/.p10k-noicons.zsh
# This needs a NERD font
ln -f -s ${MY_PATH}/p10k.zsh ~/.p10k.zsh && cp ~/.p10k.zsh ~/.p10k-icons.zsh

# fzf-tab
ln -f -s ${MY_PATH}/fzf-tab ${MY_PATH}/oh-my-zsh/custom/plugins/fzf-tab
ln -f -s ${MY_PATH}/lessfilter.sh ~/.lessfilter.sh

# run update
bash ${MY_PATH}/update.sh