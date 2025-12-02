# ~/.zshrc

# Habilitar autocompletado
autoload -Uz compinit
compinit

# Función para cargar Starship solo en Kitty

# Habilitar historial
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt share_history

# Colores básicos
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Alias básicos
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'


if [[ "$TERM" != "linux" ]]; then
    eval "$(starship init zsh)"
else
    PROMPT='%n@%m %~ %# '
fi
