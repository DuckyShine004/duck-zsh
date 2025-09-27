# Exports
export ZSH_DIR="$HOME/.config/zsh"
export ZSH="$ZSH_DIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Enable Custom Variables
ZSH_THEME="dragosmara"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode)

# Sourcing
source $ZSH/oh-my-zsh.sh
source $ZSH_DIR/functions/nvims.zsh
source $ZSH_DIR/functions/workspace.zsh
source $ZSH_DIR/functions/file.zsh
source $ZSH_DIR/functions/directory.zsh

# Aliases
alias nf='neofetch'
alias ff='fastfetch'
# alias vi='nvim'
alias vi='vim'
alias ls='lsd'
alias clear='clear && printf "\e[3J"'
alias template='~/.config/scripts/template.sh'
alias screenkey="GDK_BACKEND=x11 screenkey"
alias kitty="kitty -o linux_display_server=x11"
# alias gcloud='~/google-cloud-sdk/bin/gcloud'

# Exports
export XDG_CONFIG_HOME=$HOME/.config
export PATH="/usr/local/bin:$PATH"
export PYTHONPATH="$(python3 -m site --user-site):$PYTHONPATH"
# export NODE_ENV=development
# export PATH="$(go env GOPATH)/bin:$PATH"

# Export this version for the nightly build
# export PATH="$HOME/Documents/software/nightly/bin:$PATH"

# Created by `pipx` on 2024-04-02 09:11:42
export PATH="$PATH:/Users/duckyshine04/.local/bin"
# export TERM=xterm-kitty


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/duckyshine04/google-cloud-sdk/path.zsh.inc' ]; then . '/home/duckyshine04/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/duckyshine04/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/duckyshine04/google-cloud-sdk/completion.zsh.inc'; fi

pokemon-colorscripts --no-title -n psyduck

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/home/duckyshine04/.local/bin:/home/duckyshine04/.config/nvm/versions/node/v18.20.4/bin:/home/duckyshine04/google-cloud-sdk/bin:/home/duckyshine04/.sdkman/candidates/maven/current/bin:/home/duckyshine04/.sdkman/candidates/java/current/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/Users/duckyshine04/.local/bin
export PATH=/home/duckyshine04/.local/bin:/home/duckyshine04/.config/nvm/versions/node/v18.20.4/bin:/home/duckyshine04/google-cloud-sdk/bin:/home/duckyshine04/.sdkman/candidates/maven/current/bin:/home/duckyshine04/.sdkman/candidates/java/current/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/Users/duckyshine04/.local/bin
export PATH=/home/duckyshine04/.local/bin:/home/duckyshine04/.config/nvm/versions/node/v18.20.4/bin:/home/duckyshine04/google-cloud-sdk/bin:/home/duckyshine04/.sdkman/candidates/maven/current/bin:/home/duckyshine04/.sdkman/candidates/java/current/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/Users/duckyshine04/.local/bin
export PATH=/home/duckyshine04/.local/bin:/home/duckyshine04/.config/nvm/versions/node/v18.20.4/bin:/home/duckyshine04/google-cloud-sdk/bin:/home/duckyshine04/.sdkman/candidates/maven/current/bin:/home/duckyshine04/.sdkman/candidates/java/current/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/Users/duckyshine04/.local/bin

export PATH="/home/duckyshine04/.cargo/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.cargo/bin:$PATH"
