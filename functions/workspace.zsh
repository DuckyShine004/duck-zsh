WORKSPACES_FILE="${HOME}/.workspaces"
WORKSPACE_FREQUENT_FILE="${HOME}/.workspace_frequent"

function workspace-add() {
    if [ $# -ne 2 ]; then
        echo "Usage: workspace-add <name> <path>"

        return 1
    fi

    local name=$1
    local workspace_path=$2

    if [ "$workspace_path" = "." ]; then
        workspace_path=$(pwd)
    fi

    echo "${name}=${workspace_path}" >>"$WORKSPACES_FILE"

    echo "Workspace '${name}: ${workspace_path}' added"
}

function workspace-open() {
    local selection

    selection=$(
        awk 'BEGIN{FS="=";OFS="\t"} NF {p=$0; sub(/^[^=]*=/,"",p); print $1,p}' "$WORKSPACES_FILE" |
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
          workspace_path=\$1
          if [ -d \"\$workspace_path\" ]; then
            tree -dC --prune -I '\''node_modules|.git|.venv|__pycache__|clangd|CMakeFiles|build|lib|Library|Samples|Temp'\'' -- \"\$workspace_path\"
          else
            echo \"Missing directory: \$workspace_path\"
          fi
        " _ {2}' \
                --preview-window=right,80%:wrap
    ) || {
        echo "No workspace selected."

        return 0
    }

    # Get the workspace path from selection
    local workspace="${selection%%$'\t'*}"
    local workspace_path="${selection#*$'\t'}"

    if [[ -d "$workspace_path" ]]; then
        cd -- "$workspace_path" || {
            echo "Failed to cd into $workspace_path"

            return 1
        }
        echo "Switched to workspace: $workspace ($workspace_path)"
    else
        echo "Directory does not exist: $workspace_path"
    fi
}

function workspace-track-frequent() {
    local dir="$PWD"
    local tmp
    local count=0

    [[ -d "$dir" ]] || return 0

    tmp="$(mktemp)" || return 1

    if [[ -f "$WORKSPACE_FREQUENT_FILE" ]]; then
        count=$(awk -F '\t' -v d="$dir" '$1 == d { print $2; found=1 } END { if (!found) print 0 }' "$WORKSPACE_FREQUENT_FILE")
    fi

    {
        printf '%s\t%s\n' "$dir" "$((count + 1))"
        [[ -f "$WORKSPACE_FREQUENT_FILE" ]] && awk -F '\t' -v d="$dir" '$1 != d' "$WORKSPACE_FREQUENT_FILE"
    } >"$tmp"

    mv "$tmp" "$WORKSPACE_FREQUENT_FILE"
}

function workspace-frequent() {
    local selection
    local workspace_path

    [[ -f "$WORKSPACE_FREQUENT_FILE" ]] || {
        echo "No tracked workspaces found."
        return 0
    }

    selection=$(
        sort -t $'\t' -k2,2nr "$WORKSPACE_FREQUENT_FILE" |
            fzf \
                --height=100% \
                --border=sharp \
                --layout=reverse \
                --prompt='freq ∷ ' \
                --pointer='▶' \
                --marker='⇒' \
                --color=bg+:-1,gutter:-1 \
                --bind='tab:down,btab:up' \
                --delimiter=$'\t' \
                --with-nth=1 \
                --preview='bash -c "
                    workspace_path=\$1
                    if [ -d \"\$workspace_path\" ]; then
                        tree -dC --prune -I '\''node_modules|.git|.venv|__pycache__|clangd|CMakeFiles|build|lib|Library|Samples|Temp'\'' -- \"\$workspace_path\"
                    else
                        echo \"Missing directory: \$workspace_path\"
                    fi
                " _ {1}' \
                --preview-window=right,80%:wrap
    ) || {
        echo "No frequent workspace selected."
        return 0
    }

    workspace_path="${selection%%$'\t'*}"

    if [[ -d "$workspace_path" ]]; then
        cd -- "$workspace_path" || {
            echo "Failed to cd into $workspace_path"
            return 1
        }
        echo "Switched to frequent workspace: $workspace_path"
    else
        echo "Directory does not exist: $workspace_path"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd workspace-track-frequent
