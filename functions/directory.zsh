find-directory() {
    sudo -v 2>/dev/null || true

    local current_dir=$PWD

    local had_xtrace=0
    local had_verbose=0

    [[ -o xtrace ]] && {
        had_xtrace=1
        set +x
    }

    [[ -o verbose ]] && {
        had_verbose=1
        set +v
    }

    while true; do
        local input
        local key
        local selection

        input=$(
            {
                printf '%s\n' ".."
                printf '%s\n' "[Open here]"
                fd -a -t d -d 1 . "$current_dir" -HI -E .git -E .venv -E node_modules -E __pycache__ -E clangd -E build -E lib
            } | fzf \
                --height=100% --layout=reverse --border=sharp \
                --prompt="∷ ${current_dir%/}/" \
                --pointer='▶' \
                --marker='⇒' \
                --header="ENTER/→: into • ←: up • ESC: cancel" --header-first \
                --color=bg+:-1,gutter:-1 \
                --bind="tab:down,btab:up" \
                --expect=enter,right,left,esc \
                --preview '
                  selection={}
                  case "$selection" in
                    "..")          dir="$(dirname -- "'"$current_dir"'")" ;;
                    "[Open here]") dir="'"$current_dir"'" ;;
                    *)             dir="$selection" ;;
                  esac
                  if command -v tree >/dev/null 2>&1; then
                    tree -aC -L 1 -- "$dir" 2>/dev/null | head -200
                  else
                    ls -A -- "$dir" 2>/dev/null | head -200
                  fi
                '
        ) || return

        key=${input%%$'\n'*}
        selection=${input#*$'\n'}

        [[ $key == esc || -z $selection ]] && return

        # Navigation back to parent case
        if [[ $key == left || $selection == ".." ]]; then
            local parent
            parent=$(dirname -- "$current_dir")
            [[ $parent != "$current_dir" ]] && current_dir=$parent
            continue
        fi

        # Navigation to current directory case
        if [[ $selection == "[Open here]" ]]; then
            builtin cd -- "$current_dir"
            return
        fi

        # Navigation into child directory case
        if [[ -d $selection ]]; then
            current_dir=$selection
            continue
        fi
    done

    ((had_xtrace)) && set -x
    ((had_verbose)) && set -v
}
