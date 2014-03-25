# Set local path where 'zshconfig/' is located.
# ${ZSH_PWD} will be modified by 'install.sh' script.
ZSH_PWD=${MY_PATH}

# load zshrc
source ${ZSH_PWD}/zshrc

# unset internal variable
unset ZSH_PWD

