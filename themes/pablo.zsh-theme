# Based on few oh-my-zsh themes: 'lukerandall', 'kphoen', 'Soliah', 'smt'

# Return code (test it runing 'false')
local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

# Git
SP=' ' # Git modifiers will be separated by one space.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}$SP✭%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}$SP✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}$SP☀%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}$SP✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}$SP➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}$SP═%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}$SP⚡%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}$SP!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}$SP✓%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[green]%}$SP⬇%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[green]%}$SP⬆%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[green]%}$SP▾▴%{$reset_color%}"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  BAR="%{$fg_bold[blue]%}|"
  [[ -n $GIT_STATUS ]] && GIT_STATUS="$BAR$(git_remote_status)$GIT_STATUS$SP"
#   [[ -n $(git_remote_status) ]] && GIT_REMOTE_STATUS="$BAR$(git_remote_status)"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$BAR$(git_prompt_short_sha)$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


# PROMT
PROMPT=$'%{$fg_bold[cyan]%}%n@%M%{$reset_color%} %{$fg[yellow]%}%d%{$reset_color%} $(git_prompt_info)\n » '

# RPS1
RPS1="${return_code} %{$fg_bold[black]%}[ %T - `date '+%d/%m'` ]%{$reset_color%}"
