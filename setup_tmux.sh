#!/bin/bash
test type tmux >/dev/null 2>&1 && echo "TMUX isn't installed. Skipping." && exit 1
ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.tmux"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
