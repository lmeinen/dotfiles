# Load zsh custom functions
source $ZDOTDIR/functions.zsh

# Load custom environment variables
source $ZDOTDIR/env.zsh

# Load Antigen
source $ZDOTDIR/antigen/antigen.zsh
antigen init $ZDOTDIR/antigen/antigenrc

# Load aliases
source $ZDOTDIR/aliases.zsh

# Set custom ZSH options
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Run wal to apply generated color scheme
(cat ~/.cache/wal/sequences &)

# Load Ubique terminal magic
source ~/.terminal-magic/env
