# Share history between multiple shells
setopt share_history
setopt HIST_IGNORE_ALL_DUPS

# Needed for dircycle implementation (see alias.sh)
setopt autopushd pushdsilent pushdtohome

# Remove duplicate entries
setopt pushdignoredups

# This reverts the +/- operators.
setopt pushdminus

# Load incremental autocomplete
source $ZSH_PWD/incr-autocomplete/load.sh

