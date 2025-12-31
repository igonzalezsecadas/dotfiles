# ~/.zshrc

# zinit and plugin directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light olets/zsh-transient-prompt

zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo

autoload -U compinit && compinit
zinit cdreplay -q
# End of zinit and plugin loading section

# Aliases
alias ls='ls --color'
alias lsa='ls -a'
alias lsal='ls -la'

alias tmn='tmux new-session -t'
alias tma='tmux a -t' 

alias gst='git status'
alias gc='git commit'
alias ga='git add'
alias gpo='git push origin'
alias gpu='git pull origin'

proyectos_key() {
  LBUFFER+=" ~/.config/tmux/repos.sh"
  zle accept-line
}

zle -N proyectos_key
bindkey '^p' proyectos_key

# Keybinds
set -o vi
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# Unable case sensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "{(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
HISDUP=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Starship prompt only showing on terminal emulator
if [[ "$TERM" != "linux" ]]; then
    eval "$(starship init zsh)"
    TRANSIENT_PROMPT_PROMPT='$(starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
TRANSIENT_PROMPT_RPROMPT='$(starship prompt --right --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship module character)'
else
    PROMPT='%n@%m %~ %# '
fi
