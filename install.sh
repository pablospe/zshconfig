#!/bin/sh

# Files to be overwritten
FILES='.zshrc'

# Create backup
PATH_BACKUP='~/.backup/'
echo mkdir -p $PATH_BACKUP
mkdir -p $PATH_BACKUP 

for i in $FILES; do
  echo mv -f ~/$i $PATH_BACKUP
  mv -f ~/$i $PATH_BACKUP
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
ZSHRC="${MY_PATH}/zshrc"

# ZSH_PWD variable inside zshrc (avoiding defaults)
sed -i "1d" $ZSHRC
sed -i "1i\ZSH_PWD=${MY_PATH}" $ZSHRC

# Installing
echo ln -s $ZSHRC ~/.zshrc
ln -s $ZSHRC ~/.zshrc

