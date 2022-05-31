# Share history between multiple shells
setopt share_history
setopt HIST_IGNORE_ALL_DUPS

# Enter directory without 'cd'
setopt auto_cd

# Needed for dircycle implementation (see alias.sh)
setopt autopushd pushdsilent pushdtohome

# Remove duplicate entries
setopt pushdignoredups

# This reverts the +/- operators.
setopt pushdminus

# Load incremental autocomplete
#source $ZSH_PWD/incr-autocomplete/load.sh

#
# FZF
#
# ALT+T (file), Alt-C (folders)
#
export FZF_DEFAULT_OPTS="          \
  --exact                          \
  --height ${FZF_TMUX_HEIGHT:-30%} \
  --layout=reverse --border        \
  --info=hidden                    \
  --prompt='$  '                   \
  --pointer='=>'                   \
  --marker='+'                     \
  --cycle                          \
  --select-1                       \
  --color=dark                     \
  --color=fg:-1,bg:-1,hl:#fb8aa4,fg+:-1,bg+:-1,hl+:#55E579 \
  --color=info:#af87ff,prompt:#fb8aa4,pointer:#55E579,marker:#55E579,spinner:#55E579
"

export FZF_CTRL_R_OPTS="           \
  --with-nth 2..                   \
  --bind 'shift-tab:up,tab:down'   \
"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ${ZSH_PWD}/fzf/zsh-interactive-cd.plugin.zsh
source ${ZSH_PWD}/fzf/forgit.plugin.zsh


# zsh-syntax-highlighting
source $ZSH_PWD/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
