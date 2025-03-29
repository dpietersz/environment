# ~/.bashrc

# Exit if not interactive
[[ $- != *i* ]] && return

# Source modular configs
for file in ~/.bashrc.d/*.sh; do
  [[ -r "$file" ]] && source "$file"
done
