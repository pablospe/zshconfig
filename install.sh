#!/bin/sh

# Pull the latest changes and update submodules
git pull && git submodule update --init --recursive

# Files to be overwritten
FILES='.zshrc .p10k.zsh'

# Create backup
PATH_BACKUP=~/backup/
echo mkdir -p $PATH_BACKUP
mkdir -p $PATH_BACKUP

for i in $FILES; do
  echo mv ~/$i $PATH_BACKUP
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
echo ln -f -s $ZSHRC ~/.zshrc
ln -f -s $ZSHRC ~/.zshrc

# Ignore local changes
echo git update-index --assume-unchanged $ZSHRC
git update-index --assume-unchanged $ZSHRC

# Adding 'pablo' theme to oh-my-zsh/theme
echo ln -f -s $MY_PATH/themes/pablo.zsh-theme $MY_PATH/oh-my-zsh/themes/
ln -f -s $MY_PATH/themes/pablo.zsh-theme $MY_PATH/oh-my-zsh/custom/themes/

# Powerlevel10 (it needs a NERD font)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${MY_PATH}/oh-my-zsh/custom/themes/powerlevel10k
echo ln -f -s ${MY_PATH}/p10k.zsh ~/.p10k.zsh
ln -f -s ${MY_PATH}/p10k.zsh ~/.p10k.zsh
echo ln -f -s ${MY_PATH}/p10k-noicons.zsh ~/.p10k-noicons.zsh
ln -f -s ${MY_PATH}/p10k-noicons.zsh ~/.p10k-noicons.zsh
