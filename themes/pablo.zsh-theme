# Based on few oh-my-zsh themes: 'lukerandall', 'kphoen', 'Soliah', 'smt', 'sorin'

# Color shortcuts
R=$fg_bold[red]
G=$fg_bold[green]
M=$fg_bold[magenta]
Y=$fg_bold[yellow]
B=$fg_bold[blue]
C=$fg_bold[cyan]
RED=$fg[red]
YELLOW=$fg[yellow]
RESET=$reset_color

# Return code
local return_code="%(?..%{$R%}%? ↵%{$RESET%})"

# Git prompt info
#
# '●': staged,  '✚': changed, '…': untracked,
# '✖': deleted, '➜': renamed, '═': unmerged
#
# (master|70c2952|↑3 ✚1): on branch master, ahead of remote by 3 commits, 1 file changed but not staged
# (status|21ab52b|●2): on branch status, 2 files staged
# (master|70c2952|✖2 ✚3): on branch master, 2 files deleted, 3 files changed
# (experimental|70c2952|↓2 ↑3 ✔): on branch experimental; your branch has diverged by 3 commits, remote by 2 commits; the repository is otherwise clean
#
# Some ideas from: https://github.com/olivierverdier/zsh-git-prompt
#
function git_prompt() {
  # Git status procelain
  INDEX=$(git status --porcelain -b 2>/dev/null)
  if [ $? -ne 0 ]; then
    # It is not a git repo
    return
  fi

  # Number of staged files, modified files, etc.
  GIT_STAGED=$(echo $INDEX | grep -E '^A |^M ' | wc -l)
  GIT_DELETED=$(echo $INDEX | grep -E '^ D |^D  |^AD ' | wc -l)
  GIT_RENAMED=$(echo $INDEX | grep '^R  '  | wc -l)
  GIT_MODIFIED=$(echo $INDEX | grep -E '^ M |^AM |^ T |^MM ' | wc -l)
  GIT_UNMERGED=$(echo $INDEX | grep '^UU ' | wc -l)
  GIT_UNTRACKED=$(echo $INDEX | grep -E '^\?\? ' | wc -l)

  # Number of commit 'ahead' and 'behind' current branch
  GIT_AHEAD=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
  GIT_BEHIND=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

  # Modifiers will be separated by $SP
  SP=' '

  ZSH_THEME_GIT_PROMPT_UNTRACKED="$SP$RED…${GIT_UNTRACKED}$RESET"
  ZSH_THEME_GIT_PROMPT_ADDED="$SP$C●${GIT_STAGED}$RESET"
  ZSH_THEME_GIT_PROMPT_MODIFIED="$SP$Y✚${GIT_MODIFIED}$RESET"
  ZSH_THEME_GIT_PROMPT_DELETED="$SP$R✖${GIT_DELETED}$RESET"
  ZSH_THEME_GIT_PROMPT_RENAMED="$SP$M➜${GIT_RENAMED}$RESET"
  ZSH_THEME_GIT_PROMPT_UNMERGED="$SP$Y═${GIT_UNMERGED}$RESET"

  #ZSH_THEME_GIT_PROMPT_DIRTY="$SP$R⚡$RESET"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN="$SP$G✔$RESET"

  ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$SP$YELLOW⬇${GIT_BEHIND}$RESET"
  ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$SP$G⬆${GIT_AHEAD}$RESET"
  ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$SP$R▾▴$RESET${ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE}${ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE}"

  # Format git_prompt_short_sha()
  ZSH_THEME_GIT_PROMPT_SHA_BEFORE="$M"
  ZSH_THEME_GIT_PROMPT_SHA_AFTER="$RESET"

  # Initial git status using variables above
  STATUS=$(git_prompt_status)

  # remote_status or git_dirty
  if [[ -n $STATUS ]]; then
    STATUS="$(git_remote_status)$STATUS"
  else
    STATUS="$(parse_git_dirty)"
  fi

  # Remove extra spaces
  STATUS=$STATUS[2,-1]

  # (BRANCH|HASH|STATUS)
  BAR="$B|"
  PREFIX="$B($RED"
  SUFFIX="$B)$RESET"
  BRANCH=$(git symbolic-ref HEAD --short 2>/dev/null) && BRANCH=$BRANCH$BAR
  HASH=$(git_prompt_short_sha) && HASH=$HASH$BAR
  echo "$PREFIX${BRANCH}${HASH}$STATUS$SUFFIX"
}

# PROMT
PROMPT=$'%{$C%}%n@%M%{$RESET%} %{$YELLOW%}%d%{$RESET%} $(git_prompt)\n » '

# RPS1
RPS1="${return_code} %{$fg_bold[black]%}[ %T - `date '+%d/%m'` ]%{$RESET%}"
