# ~/.bash_profile

# Source .bashrc if present
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Set TERM appropriately
if [[ -n "$TMUX" ]]; then
  [[ "$TERM_PROGRAM" == "WezTerm" && -n "$WEZTERM_CONFIG_DIR" ]] && export TERM="xterm-256color" || export TERM="tmux-256color"
elif [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  export TERM="wezterm"
else
  export TERM="xterm-256color"
fi

# Linuxbrew support on Linux distros
if grep -qiE 'ubuntu|fedora|gentoo' /etc/os-release 2>/dev/null; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

