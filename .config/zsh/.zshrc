
# Load zsh custom functions
source $ZDOTDIR/functions.zsh

# Load custom environment variables
source $ZDOTDIR/env.zsh

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME=""
fpath+=($HOME/repos/pure)

plugins=(
	git
	gitfast
	command-not-found
	history-substring-search
	colored-man-pages
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Load pure prompt
autoload -U promptinit; promptinit
prompt pure

# Load aliases
source $ZDOTDIR/aliases.zsh

# Set custom ZSH options
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
unsetopt pushd_ignore_dups

# Adds Fish shell-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
