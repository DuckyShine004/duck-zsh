FZF_PREVIEW=$HOME/.config/zsh/scripts/fzf/fzf-preview.sh

find-file() {
    sudo -v 2>/dev/null || true

    fd . . -a -t f -HI \
        -E .git \
        -E build \
        -E node_modules \
        -E target \
        -E clangd \
        -E .next \
        -E __pycache__ \
        -E .venv \
        -E lib \
        -E .cache |
        fzf \
            --height=100% \
            --border=sharp \
            --layout=reverse \
            --prompt='∷ ' \
            --pointer='▶' \
            --marker='⇒' \
            --color=bg+:-1,gutter:-1 \
            --bind='tab:down,btab:up' \
            --preview "$FZF_PREVIEW {}"
}
