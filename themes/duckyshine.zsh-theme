# duckyshine.zsh-theme

setopt prompt_subst
zmodload zsh/datetime 2>/dev/null

# Make RPROMPT flush with the right edge
ZLE_RPROMPT_INDENT=0

# -----------------------------
# Colours
# -----------------------------

DUCKY_RESET="%{$reset_color%}"

# Catppuccin-ish palette
DUCKY_BG="#1e1e2e"
DUCKY_SURFACE="#313244"
DUCKY_SURFACE2="#45475a"
DUCKY_TEXT="#cdd6f4"
DUCKY_MAUVE="#cba6f7"
DUCKY_BLUE="#89b4fa"
DUCKY_SKY="#89dceb"
DUCKY_GREEN="#a6e3a1"
DUCKY_YELLOW="#f9e2af"
DUCKY_RED="#f38ba8"
DUCKY_PEACH="#fab387"

# Rounded separators
DUCKY_LEFT_ROUND=""
DUCKY_RIGHT_ROUND=""

# -----------------------------
# Truecolor helpers
# -----------------------------

function ducky_fg() {
    echo -n "%F{$1}"
}

function ducky_bg() {
    echo -n "%K{$1}"
}

function ducky_clear() {
    echo -n "%k%f"
}

# Usage:
# ducky_segment bg fg "content"
function ducky_segment() {
    local bg="$1"
    local fg="$2"
    local content="$3"

    echo -n "%F{$bg}${DUCKY_LEFT_ROUND}%K{$bg}%F{$fg}${content}%k%F{$bg}${DUCKY_RIGHT_ROUND}%f"
}

# Left edge segment joined into the next segment.
# Draws the right separator using the next segment's background.
function ducky_segment_left_edge_join() {
    local bg="$1"
    local fg="$2"
    local next_bg="$3"
    local content="$4"

    echo -n "%K{$bg}%F{$fg}${content}%K{$next_bg}%F{$bg}${DUCKY_RIGHT_ROUND}%f"
}

# Right edge segment: only left round, no right round.
function ducky_segment_right_edge() {
    local bg="$1"
    local fg="$2"
    local content="$3"

    echo -n "%F{$bg}${DUCKY_LEFT_ROUND}%K{$bg}%F{$fg}${content}%k%f"
}

# Right edge two-part segment:
# left part has normal left round, middle separator joins into right part,
# right part has no right round and flushes to screen edge.
function ducky_segment_right_edge_pair() {
    local left_bg="$1"
    local left_fg="$2"
    local right_bg="$3"
    local right_fg="$4"
    local left_content="$5"
    local right_content="$6"

    echo -n "%F{$left_bg}${DUCKY_LEFT_ROUND}%K{$left_bg}%F{$left_fg}${left_content}%K{$right_bg}%F{$left_bg}${DUCKY_RIGHT_ROUND}%F{$right_fg}${right_content}%k%f"
}

# Middle/right-adjacent segment: no left round, only right round.
# Useful for joining directly after another segment.
function ducky_segment_no_left_round() {
    local bg="$1"
    local fg="$2"
    local content="$3"

    echo -n "%K{$bg}%F{$fg}${content}%k%F{$bg}${DUCKY_RIGHT_ROUND}%f"
}

# Optional tiny gap between separate bubbles.
function ducky_gap() {
    echo -n " "
}

# -----------------------------
# Git status icons
# -----------------------------

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$DUCKY_RED}⚡%f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{$DUCKY_RED}!%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{$DUCKY_GREEN}✓%f"

ZSH_THEME_GIT_PROMPT_ADDED="%F{$DUCKY_GREEN}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{$DUCKY_BLUE}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{$DUCKY_RED}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{$DUCKY_MAUVE}➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{$DUCKY_YELLOW}═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{$DUCKY_SKY}✭%f"

# -----------------------------
# Prompt char
# -----------------------------

function ducky_prompt_char() {
    echo -n "%F{$DUCKY_YELLOW} ╰%f"
}

# -----------------------------
# Shortened directory
# -----------------------------

# ~/foo/bar/car -> ~/f/b/car
# /usr/local/bin -> /u/l/bin
function ducky_pwd() {
    local path="${PWD/#$HOME/~}"
    local -a parts
    local result=""
    local current parent

    if [[ "$path" == "~" || "$path" == "/" ]]; then
        echo -n "%F{$DUCKY_SKY}${path}%f"
        return
    fi

    parts=("${(@s:/:)path}")
    current="${parts[-1]}"

    if [[ "${parts[1]}" == "~" ]]; then
        result="~"

        for parent in "${parts[@]:1:${#parts[@]}-2}"; do
            [[ -z "$parent" ]] && continue
            result+="/${parent[1]}"
        done

        echo -n "%F{$DUCKY_TEXT}${result}/%F{$DUCKY_SKY}${current}%f"
        return
    fi

    result="/"

    for parent in "${parts[@]:1:${#parts[@]}-2}"; do
        [[ -z "$parent" ]] && continue
        result+="${parent[1]}/"
    done

    echo -n "%F{$DUCKY_TEXT}${result}%F{$DUCKY_SKY}${current}%f"
}

# -----------------------------
# Left prompt
# -----------------------------

function ducky_left_prompt() {
    ducky_segment_left_edge_join "$DUCKY_YELLOW" "$DUCKY_BG" "$DUCKY_BG" " 󰇥 "
    ducky_segment_no_left_round "$DUCKY_BG" "$DUCKY_TEXT" " %F{$DUCKY_BLUE}%F{$DUCKY_TEXT}  $(ducky_pwd) "

    local git_text
    git_text="$(ducky_git_left)"

    if [[ -n "$git_text" ]]; then
        ducky_gap
        echo -n "$git_text"
    fi
}

# -----------------------------
# Left prompt: git
# -----------------------------

function ducky_git_branch() {
    local branch

    branch="$(git_current_branch 2>/dev/null)"

    if [[ -n "$branch" ]]; then
        echo -n "%F{$DUCKY_PEACH} ${branch}%f"
    fi
}

function ducky_git_status() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    local stats added deleted text
    local -i added_total=0
    local -i deleted_total=0

    stats="$(
        {
            git diff --numstat 2>/dev/null
            git diff --cached --numstat 2>/dev/null
        }
    )"

    [[ -z "$stats" ]] && return

    while IFS=$'\t' read -r added deleted _; do
        [[ "$added" == "-" || "$deleted" == "-" ]] && continue

        added_total=$(( added_total + added ))
        deleted_total=$(( deleted_total + deleted ))
    done <<< "$stats"

    [[ "$added_total" -eq 0 && "$deleted_total" -eq 0 ]] && return

    text=""

    if (( added_total > 0 )); then
        text+="%F{$DUCKY_GREEN}  ${added_total}%f"
    fi

    if (( deleted_total > 0 )); then
        text+="%F{$DUCKY_RED}  ${deleted_total}%f"
    fi

    echo -n "$text"
}

function ducky_git_left() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    local branch diff
    branch="$(ducky_git_branch)"
    diff="$(ducky_git_status)"

    [[ -z "$branch" && -z "$diff" ]] && return

    echo -n "${branch}${diff}"
}

# -----------------------------
# Command duration
# -----------------------------

DUCKY_CMD_START_TIME=""
DUCKY_CMD_DURATION=""

function ducky_preexec() {
    DUCKY_CMD_START_TIME=$EPOCHREALTIME
}

function ducky_precmd() {
    local exit_code=$?
    local elapsed
    local -i ms seconds minutes

    DUCKY_LAST_EXIT_CODE=$exit_code

    if [[ -n "$DUCKY_CMD_START_TIME" ]]; then
        elapsed=$(( EPOCHREALTIME - DUCKY_CMD_START_TIME ))
        ms=$(( elapsed * 1000 ))

        if (( ms < 1000 )); then
            DUCKY_CMD_DURATION="${ms}ms"
        elif (( ms < 60000 )); then
            seconds=$(( ms / 1000 ))
            DUCKY_CMD_DURATION="${seconds}s"
        else
            minutes=$(( ms / 60000 ))
            seconds=$(( (ms / 1000) % 60 ))
            DUCKY_CMD_DURATION="${minutes}m${seconds}s"
        fi
    else
        DUCKY_CMD_DURATION=""
    fi

    DUCKY_CMD_START_TIME=""
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec ducky_preexec
add-zsh-hook precmd ducky_precmd

function ducky_cmd_time() {
    if [[ -n "$DUCKY_CMD_DURATION" ]]; then
        ducky_segment_right_edge_pair \
            "$DUCKY_MAUVE" "$DUCKY_BG" \
            "$DUCKY_BG" "$DUCKY_TEXT" \
            "  " " ${DUCKY_CMD_DURATION} "
    fi
}

function ducky_return_status() {
    if [[ "$DUCKY_LAST_EXIT_CODE" != "0" ]]; then
        ducky_segment "$DUCKY_RED" "$DUCKY_BG" " ⏎ ${DUCKY_LAST_EXIT_CODE} "
    fi
}

# -----------------------------
# Final prompt
# -----------------------------

PROMPT='
$(ducky_left_prompt)
$(ducky_prompt_char) '

RPROMPT='$(ducky_return_status)$(ducky_cmd_time)'
