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
# Ctrl+T (file), Alt-C (folders)
#
export FZF_DEFAULT_OPTS="          \
  --exact                          \
  --height ${FZF_TMUX_HEIGHT:-50%} \
  --info=inline-right              \
  --no-separator                   \
  --layout=reverse                 \
  --prompt='$  '                   \
  --pointer='=>'                   \
  --marker='+'                     \
  --cycle                          \
  --select-1                       \
  --color=dark                     \
  --bind '?:toggle-preview,ctrl-a:select-all,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-l:clear-query,home:first,end:last,enter:accept-non-empty,alt-down:down,alt-up:up,right:accept-non-empty,alt-right:accept-non-empty,alt-left:close,left:close,alt-n:down,alt-p:up,insert:toggle-down' \
  --color='fg:-1,bg:-1,hl:#fb8aa4,fg+:-1,bg+:-1,hl+:#55E579' \
  --color='info:#af87ff,prompt:#fb8aa4,pointer:#55E579,marker:#55E579,spinner:#55E579'
"

# fzf-tab does not follow FZF_DEFAULT_OPTS.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

export FZF_CTRL_R_OPTS="           \
  --with-nth 2..                   \
  --bind 'shift-tab:up,tab:down'   \
"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ${ZSH_PWD}/fzf/zsh-interactive-cd.plugin.zsh
source ${ZSH_PWD}/fzf/forgit.plugin.zsh


# zsh-syntax-highlighting
source $ZSH_PWD/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)
# https://github.com/zsh-users/zsh-autosuggestions/issues/678
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)

#
# fzf-tab
#
# note: use `toggle-fzf-tab` command to disable it
#
# Minimal sizes.
zstyle ':fzf-tab:*' fzf-min-height 30
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 200 15
# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Preview directory's content when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --group-directories-first --color $realpath'
# Manuals
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
# Switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' switch-group F1 F2
# Show file contents
# https://github.com/Aloxaf/fzf-tab/wiki/Preview
zstyle ':fzf-tab:complete:(vi|vim|l|ls|code|m):*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:micro:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='|~/.lessfilter.sh %s'
# Environment variable
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# Git
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
  'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --graph --pretty="%C(#ff69b4)%h%Creset %C(bold blue)%al%Creset%C(auto)%d%Creset %s %Cgreen%cs (%ar)" --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
# Continuous-trigger.
# zstyle ':fzf-tab:*' continuous-trigger '/' # fzf-tab default
# zstyle ':fzf-tab:*' continuous-trigger 'ctrl-e'
# zstyle ':fzf-tab:*' continuous-trigger 'alt-right'
# zstyle ':fzf-tab:*' continuous-trigger 'enter'
# zstyle ':fzf-tab:*' continuous-trigger 'alt-right'
# zstyle ':fzf-tab:*' continuous-trigger 'ctrl-/'
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-space'

# zstyle ':fzf-tab:*' continuous-trigger 'tab'

# First tab in empty line.
# https://unix.stackexchange.com/a/14231
# zstyle ':completion:*' insert-tab false
