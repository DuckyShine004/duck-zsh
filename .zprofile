# Homebrew shell environment
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Pyenv root
export PYENV_ROOT="$HOME/.pyenv"

# Path variables
typeset -U path

path=(
    "/opt/homebrew/bin"
    "/usr/local/bin"
    "$HOME/.local/bin"
    "$PYENV_ROOT/bin"
    $path
)

eval "$(pyenv init --path)"
