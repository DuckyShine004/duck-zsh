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
    local selection

    selection=$(
        awk 'BEGIN{FS="=";OFS="\t"} NF {p=$0; sub(/^[^=]*=/,"",p); print $1,p}' ~/.workspaces |
            fzf \
                --height=100% \
                --border=sharp \
                --layout=reverse \
                --prompt='∷ ' \
                --pointer='▶' \
                --marker='⇒' \
                --color=bg+:-1,gutter:-1 \
                --bind='tab:down,btab:up' \
                --delimiter='\t' \
                --with-nth=1 \
                --preview='bash -c "
          path=\$1
          if [ -d \"\$path\" ]; then
            tree -aC --prune -I '\''node_modules|.git|.venv|__pycache__|clangd|CMakeFiles|build|lib'\'' -- \"\$path\"
          else
            echo \"Missing directory: \$path\"
          fi
        " _ {2}' \
                --preview-window=right,80%:wrap
    ) || {
        echo "No workspace selected."

        return 0
    }

    # Get the workspace path from selection
    local workspace="${selection%%$'\t'*}"
    local path="${selection#*$'\t'}"

    if [[ -d "$path" ]]; then
        cd -- "$path" || {
            echo "Failed to cd into $path"

            return 1
        }
        echo "Switched to workspace: $workspace ($path)"
    else
        echo "Directory does not exist: $path"
    fi
}
