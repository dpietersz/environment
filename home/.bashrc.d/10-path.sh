# 10-path.sh — PATH management

prepend_path() { [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"; }

# Common paths
prepend_path "$HOME/.local/bin"
prepend_path "$HOME/bin"
prepend_path "$SCRIPTS"
prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/go/bin"

# macOS specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  prepend_path "/opt/homebrew/bin"
  prepend_path "/opt/homebrew/sbin"
  prepend_path "/usr/local/bin"
  prepend_path "$HOME/Applications"
  prepend_path "/Users/pietersz/.config/herd-lite/bin"
  prepend_path "/Users/pietersz/.local/bin"
  prepend_path "/opt/homebrew/opt/postgresql@16/bin"
fi

