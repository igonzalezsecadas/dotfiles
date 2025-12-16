#!/bin/zsh

SESSION="default"
kitty -e tmux new-session -A -s "$SESSION"
