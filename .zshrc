# ZSH Exports
export ZSH_DIR="$HOME/.config/zsh"
export ZSH="$ZSH_DIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Set the theme
ZSH_THEME="dragosmara"

# Disable automatic terminal title
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Display dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git zsh-autosuggestions zsh-vi-mode zsh-syntax-highlighting)

# Source OMZ
source $ZSH/oh-my-zsh.sh

# Source functions
source $ZSH_DIR/functions/nvims.zsh
source $ZSH_DIR/functions/workspace.zsh
source $ZSH_DIR/functions/file.zsh
source $ZSH_DIR/functions/directory.zsh

# Aliases
alias nf='neofetch'
alias ff='fastfetch'
alias nvim='NVIM_APPNAME=nvim-chad nvim'
alias vi='nvim'
alias ls='lsd'
alias clear='clear && printf "\e[3J"'
alias template="$HOME/.config/scripts/template.sh"
alias screenkey="GDK_BACKEND=x11 screenkey"
alias kitty="kitty -o linux_display_server=x11"

# Custom paths
export XDG_CONFIG_HOME=$HOME/.config
export NVM_DIR="$HOME/.config/nvm"
export SDKMAN_DIR="$HOME/.sdkman"
export PYENV_ROOT="$HOME/.pyenv"

# Python path
export PYTHONPATH="$(python3 -m site --user-site):$PYTHONPATH"

# Path variables
typeset -U path

# BREW MUST BE FIRST
path=(
    "/opt/homebrew/bin"
    "/opt/homebrew/opt/postgresql@16/bin"
    "/usr/local/bin"
    "$(go env GOPATH)/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$PYENV_ROOT/bin"
    $path
)

# gcloud path updates and auto completion
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && . "$HOME/google-cloud-sdk/path.zsh.inc"
[[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && . "$HOME/google-cloud-sdk/completion.zsh.inc"

# NVM auto completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Pyenv
eval "$(pyenv init -)"

# SDKMAN (must be at EOF)
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# History
setopt append_history
setopt hist_ignore_dups
setopt share_history

# Custom display script
pokemon-colorscripts --no-title -n psyduck
