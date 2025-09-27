# Custom paths
export PYENV_ROOT="$HOME/.pyenv"

# Path variables
typeset -U path

path=(
    "$HOME/.local/bin"
    "$PYENV_ROOT/bin"
    $path
)

eval "$(pyenv init --path)"
