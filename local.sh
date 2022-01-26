# Set local path where 'zshconfig/' is located.
# ${ZSH_PWD} will be modified by 'install.sh' script.
ZSH_PWD=${MY_PATH}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zshrc
source ${ZSH_PWD}/zshrc

# unset internal variable
unset ZSH_PWD

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh                  # with Nerd fonts
# [[ ! -f ~/.p10k-noicons.zsh ]] || source ~/.p10k-noicons.zsh  # without Nerd fonts
