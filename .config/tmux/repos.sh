#!/usr/bin/env bash

DIR="$HOME/dev"

# Seleccionar proyecto con fzf
project=$(find "$DIR" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)

# Si no selecciona nada, salir
[ -z "$project" ] && exit 0

session_name="$project"
project_path="$DIR/$project"

# ¿Existe la sesión?
if tmux has-session -t "$session_name" 2>/dev/null; then
    exec tmux attach-session -t "$session_name"
    exit 0
fi

# Crear nueva sesión con nvim en ventana 1
tmux new-session -d -s "$session_name" -c "$project_path" "nvim ."

# Crear ventana 2 como terminal
tmux new-window -t "$session_name" -c "$project_path"

# Entrar a la sesión
exec   tmux attach-session -t "$session_name"

