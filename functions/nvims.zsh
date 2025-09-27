function nvims() {
    items=("default" "nvim-chad" "GruVim")

    config=$(
        printf "%s\n" "${items[@]}" | fzf \
            --height=50% --layout=reverse --border=sharp \
            --prompt=" Neovim Config " \
            --pointer='▶' \
            --marker='⇒' \
            --color=bg+:-1,gutter:-1 \
            --bind="tab:down,btab:up" \
            --exit-0
    )

    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config="nvim"
    fi

    NVIM_APPNAME=$config nvim $@

    echo NVIM_APPNAME
}

function kitty-reload() {
    kill -SIGUSR1 $KITTY_PID
}
