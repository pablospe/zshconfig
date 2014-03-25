#!/bin/sh

# Files to be overwritten
FILES='.zshrc'

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
ZSHRC="${MY_PATH}/local.sh"

# ZSH_PWD variable inside 'local.sh' (avoiding defaults)
sed -i "3d" $ZSHRC
sed -i "3i\ZSH_PWD=${MY_PATH}" $ZSHRC

# Installing
echo ln -f -s $ZSHRC ~/.zshrc
ln -f -s $ZSHRC ~/.zshrc

