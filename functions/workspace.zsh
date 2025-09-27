function workspace-add() {
    if [ $# -ne 2 ]; then
        echo "Usage: workspace-add <name> <path>"

        return 1
    fi

    local name=$1
    local path=$2

    if [ "$path" = "." ]; then
        path=$(pwd)
    fi

    echo "${name}=${path}" >>~/.workspaces
    echo "Workspace '${name}: ${path}' added"
}

function workspace-open() {
    local workspace=$(cat ~/.workspaces |
        fzf --height 60% \
            --border sharp \
            --layout=reverse \
            --prompt='∷ ' \
            --pointer='▶' \
            --marker='⇒' \
            --color=bg+:-1,gutter:-1 \
            --bind='tab:down,btab:up' |
        cut -d '=' -f 1)

    if [ -n "$workspace" ]; then
        local path=$(grep "^${workspace}=" ~/.workspaces | cut -d '=' -f 2-)

        if [ -d "$path" ]; then
            cd "$path"
            echo "Switched to workspace: $workspace ($path)"
        else
            echo "Directory does not exist: $path"
        fi
    else
        echo "No workspace selected."
    fi
}
