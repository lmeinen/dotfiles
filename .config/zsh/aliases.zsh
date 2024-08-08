# Custom aliases
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias o=rifle

# Dotfiles git setup
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ETH VPN
alias ethup='sudo nmcli con up eth --ask'
alias ethdown='sudo nmcli con down eth'
