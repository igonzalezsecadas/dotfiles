#!/bin/zsh

# --- CONFIGURATION ---
# 1. The folder where your projects live
PROJECTS_DIR="$HOME/dev"

# 2. Your preferred terminal emulator (e.g., kitty, alacritty, foot, gnome-terminal)
# The syntax usually varies slightly. See "Terminal Notes" below.
TERM_CMD="kitty --e" 
# For Alacritty/Foot use: "alacritty -e" or "foot -e"
# For Gnome Terminal use: "gnome-terminal --"

# ---------------------

# 1. Get the list of directories inside PROJECTS_DIR
# We use find to get directory names only, removing the full path prefix
project_name=$(find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | \
    wofi --show dmenu --prompt "Select Project")

# 2. Exit if the user cancelled wofi (empty selection)
if [[ -z "$project_name" ]]; then
    exit 0
fi

# 3. Create a safe session name (replace dots with underscores if necessary)
# Tmux doesn't like dots in session names sometimes.
session_name=$(echo "$project_name" | tr . _)

# 4. Check if the tmux session exists
if ! tmux has-session -t="$session_name" 2> /dev/null; then
    # Session doesn't exist: Create it detached (-d)
    # Start it in the project directory (-c)
    tmux new-session -d -s "$session_name" -c "$PROJECTS_DIR/$project_name"
fi

# 5. Attach to the session inside your terminal
# We verify if we are already inside a tmux client to prevent nesting
if [[ -n "$TMUX" ]]; then
    # If run from inside tmux (rare for wofi, but possible), switch client
    tmux switch-client -t "$session_name"
else
    # Launch the terminal with the attach command
    $TERM_CMD tmux attach-session -t "$session_name"
fi
