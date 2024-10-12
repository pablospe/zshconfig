# Based on few oh-my-zsh themes: 'lukerandall', 'kphoen', 'Soliah', 'smt', 'sorin'
#
# And some ideas from: https://github.com/olivierverdier/zsh-git-prompt
#
# Self-contained: it doesn't depends on 'oh-my-zsh/lib/git.zsh'

# Color variables
R=%{$fg_bold[red]%}
G=%{$fg_bold[green]%}
M=%{$fg_bold[magenta]%}
Y=%{$fg_bold[yellow]%}
B=%{$fg_bold[blue]%}
C=%{$fg_bold[cyan]%}
RED=%{$fg[red]%}
GREEN=%{$fg[green]%}
MAGENTA=%{$fg[magenta]%}
YELLOW=%{$fg[yellow]%}
BLUE=%{$fg[blue]%}
CYAN=%{$fg[cyan]%}
RESET=%{$reset_color%}

# Return code
local return_code="%(?..$R%? ↵$RESET)"

# PROMT
PROMPT=$'$C%n@%M$RESET $YELLOW%d$RESET $(git_prompt)\n> '

# RPS1
RPROMPT="${return_code} %{$fg_bold[black]%}[ %T - `date '+%d/%m'` ]$RESET"

#
# Replaced by `gss.sh` script.
#
# #
# # Git prompt info
# #
# # '●': staged,  '+': changed, '…': untracked,
# # '⛌': deleted, '→': renamed, '═': unmerged
# #
# # (master|34r25ab|✔): on branch master; clean
# # (master|70c2952|↑3 +1): on branch master, ahead of remote by 3 commits,
# #                         1 file changed but not staged.
# # (status|21ab52b|●2 …3): on branch status, 2 files staged, 3 files untracked.
# # (master|70c2952|⛌2 +3): on branch master, 2 files deleted, 3 files changed.
# # (experimental|70c2952|▾▴ ↓2 ↑3): on branch experimental; your branch has
# #                                  diverged by 3 commits, remote by 2 commits
# #
# function git_prompt() {
#   # Git modifiers will be separated by ${SP} (empty or only one character)
#   SP=''
#   # SP=' '  # Spaces among the symbols.

#   # Git status (whith <symbol><number>)
#   STATUS="$(_git_status _git_print_symbols)"

#   # Check if it is a git repository
#   if [ $? -ne 0 ]; then
#     return
#   fi

#   # Git remote status (ahead/behind/diverged)
#   STATUS="$(_git_remote_status)$STATUS"

#   # Check if the working tree is clean
#   STATUS="$STATUS$(_git_check_clean)"

#   # Remove extra spaces
#   if [[ -n $SP ]]; then
#     STATUS=$STATUS[2,-1]
#   fi

#   # (BRANCH|HASH|STATUS)
#   BAR="$B|"
#   PREFIX="$B($RED"
#   SUFFIX="$B)$RESET"
#   BRANCH=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null) && BRANCH=$BRANCH$BAR
#   HASH=$(command git rev-parse --short HEAD 2> /dev/null) && HASH=$M$HASH$BAR
#   echo "${PREFIX}${BRANCH}${HASH}${STATUS}${SUFFIX}"
# }

# _git_status() {
#   # Git status procelain
#   SUBMODULE_SYNTAX="--ignore-submodules"
#   INDEX=$(command git status --porcelain ${SUBMODULE_SYNTAX} 2>/dev/null)

#   # Check if it is a git repository (checked twice to make it work with 'gss')
#   if [ $? -ne 0 ]; then
#     return $((-1))
#   fi

#   # Split git status in categories
#   GIT_STAGED=$(echo $INDEX | grep -E '^A |^M ')
#   GIT_MODIFIED=$(echo $INDEX | grep -E '^ M |^AM |^ T |^MM ')
#   GIT_DELETED=$(echo $INDEX | grep -E '^ D |^D  |^AD ')
#   GIT_RENAMED=$(echo $INDEX | grep '^R  ' )
#   GIT_UNMERGED=$(echo $INDEX | grep '^UU ')
#   GIT_UNTRACKED=$(echo $INDEX | grep -E '^\?\? ')

#   # Categories with different color and symbols (only can be empty the last arg)
#   func_name=$1
#   $func_name … $RED "Untracked files" $GIT_UNTRACKED
#   $func_name ═ $Y   "Unmerged files"  $GIT_UNMERGED
#   $func_name → $M   "Renamed files"   $GIT_RENAMED
#   $func_name x $R   "Deleted files"   $GIT_DELETED
#   $func_name + $Y   "Modified files"  $GIT_MODIFIED
#   $func_name ● $C   "Staged changes"  $GIT_STAGED
# }

# _git_print_symbols() {
#   str=$4
#   if [[ -n $str ]]; then
#     symbol=$1
#     color=$2
#     number=$(echo $str | wc -l)
#     echo -n ${SP}${color}${symbol}${number}$RESET
#   fi
# }

# _git_print_category() {
#   str=$4
#   if [[ -n $str ]]; then
#     symbol=$1
#     color=$2
#     echo $color$3: | sed -e 's/\(%{\|%}\)//g'
#     # Getting last column and adding symbol at the beginning
#     echo $str$RESET | sed -e 's/^.* //' | sed -e 's/\(%{\|%}\)//g' | sed "s/^/\t\t${symbol} /"
#   fi
# }

# # Checks if the working tree is clean
# _git_check_clean() {
#   if [[ -z $STATUS ]]; then
#     echo "$SP$G✔$RESET"   # clean
# #   else
# #     echo "$SP$R⚡$RESET" # dirty
#   fi
# }

# # Get the difference between the local and remote branches
# _git_remote_status() {
#   remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
#   if [[ -n ${remote} ]] ; then

#     # Number of commits 'ahead' and 'behind' (current branch)
#     GIT_AHEAD=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
#     GIT_BEHIND=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

#     # Variables
#     GIT_PROMPT_BEHIND="$SP$M↓${GIT_BEHIND}$RESET"
#     GIT_PROMPT_AHEAD="$SP$G↑${GIT_AHEAD}$RESET"
#     GIT_PROMPT_DIVERGED="$SP$R▾▴$RESET${GIT_PROMPT_AHEAD}${GIT_PROMPT_BEHIND}"

#     # Ahead, Behind or Diverged
#     if [ $GIT_AHEAD -eq 0 ] && [ $GIT_BEHIND -gt 0 ]
#     then
#       echo $GIT_PROMPT_BEHIND
#     elif [ $GIT_AHEAD -gt 0 ] && [ $GIT_BEHIND -eq 0 ]
#     then
#       echo $GIT_PROMPT_AHEAD
#     elif [ $GIT_AHEAD -gt 0 ] && [ $GIT_BEHIND -gt 0 ]
#     then
#       echo $GIT_PROMPT_DIVERGED
#     fi
#   fi
# }

# #
# # Alias gss: git status
# #
# alias gss="_git_status _git_print_category"
