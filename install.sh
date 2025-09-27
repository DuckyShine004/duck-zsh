#!/bin/bash

ZSH_CUSTOM_PLUGINS_PATH=$ZSH_CUSTOM/plugins
ZSH_CUSTOM_THEME_PATH=$ZSH_CUSTOM/themes

WORKSPACE_FILE=$HOME/.workspaces

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

    echo -e "Themes Copied!\n"
}

create_workspace_file() {
    echo -e "Creating workspace file in '$WORKSPACE_FILE'\n"

    if [ ! -e "$WORKSPACE_FILE" ]; then
        touch "$WORKSPACE_FILE"

        echo -e "File '$WORKSPACE_FILE' created\n"
    else
        echo -e "File '$WORKSPACE_FILE' already exists\n"
    fi
}

change_script_permissions() {
    echo -e "Changing script permissions\n"

    find scripts -type f -name "*.sh" -exec chmod +x {} \;
}

# ZSH setup
install_plugins
install_theme

# Miscellaneous setup
create_workspace_file

# Change permissions for scripts
change_script_permissions
