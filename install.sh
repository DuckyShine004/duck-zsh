#!/bin/bash

ZSH_CUSTOM_PLUGINS_PATH=$ZSH_CUSTOM/plugins
ZSH_CUSTOM_THEME_PATH=$ZSH_CUSTOM/themes

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

THEME_DIRECTORY=themes

install_plugins() {
    echo -e "Installing ZSH Plugins...\n"

    number_of_plugins=${#PLUGIN_LINKS[@]}

    for ((i = 0; i < number_of_plugins; i++)); do
        local plugin_directory="$ZSH_CUSTOM_PLUGINS_PATH/${PLUGIN_NAMES[$i]}"

        git clone "${PLUGIN_LINKS[$i]}" $plugin_directory

        echo
    done

    echo -e "Plugins Installed!\n"
}

install_theme() {
    echo -e "Copying Custom Themes...\n"

    cp -f $THEME_DIRECTORY/* $ZSH_CUSTOM_THEME_PATH

    echo "Themes Copied!"
}

install_plugins
install_theme
