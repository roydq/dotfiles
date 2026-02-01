autoload -Uz compinit && compinit

# History file configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

## History command configuration
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_verify

# Vim keybind
bindkey -v

# User configuration
source $HOME/.shell/environment
source $HOME/.shell/functions
source $HOME/.shell/aliases
