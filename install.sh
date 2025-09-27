#!/bin/bash

ZSH_CUSTOM_PLUGINS_PATH=$ZSH_CUSTOM/plugins

PLUGIN_LINKS=(
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/jeffreytse/zsh-vi-mode.git"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

# Could refactor to split string, but too lazy
PLUGIN_NAMES=(
    "zsh-autosuggestions"
    "zsh-vi-mode"
    "zsh-syntax-highlighting"
)

install_plugins() {
    echo "Installing ZSH Plugins"

    number_of_plugins=${#PLUGIN_LINKS[@]}

    for ((i = 0; i < number_of_plugins; i++)); do
        local clone_directory="$ZSH_CUSTOM_PLUGINS_PATH/${PLUGIN_NAMES[$i]}"

        git clone "${PLUGIN_LINKS[$i]}" $clone_directory
    done
}

install_plugins
