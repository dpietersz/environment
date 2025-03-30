# 50-aliases.sh — Custom Aliases

# ------------------ Vim / Second Brain ------------------

alias v=vim_function
alias vim=vim_function
alias or='vim "$SECOND_BRAIN"/+\ Encounters/*.md'
alias sb="cd '$SECOND_BRAIN' && vim Home.md"
alias in='cd "$SECOND_BRAIN/0-inbox/"'
alias vbn='python ~/git/python/brainfile.py'

# ------------------ Git ------------------

alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ------------------ Directory Navigation ------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias cl="clear"
alias c="clear"
alias scripts='cd "$SCRIPTS"'
alias projects='cd "$PROJECTS"'
alias dot='cd "$DOTFILES"'
alias repos='cd "$REPOS"'
alias glrepos='cd "$GLREPOS"'
alias ghrepos='cd "$GHREPOS"'
alias cdgo='cd "$GHREPOS/go/"'
alias rwdot='cd "$REPOS/github.com/rwxrob/dot"'
alias mvdot='cd "$REPOS/github.com/mischavandenburg/dotfiles"'
alias tpdot='cd "$REPOS/github.com/ThePrimeagen/.dotfiles/"'
alias ttdot='cd "$REPOS/github.com/techno-tim"'

# ------------------ Shell / Config ------------------

alias bashconf='v ~/.bashrc'
alias tmuxconf='v ~/.tmux.conf'
alias vimconf='cd ~/.config/nvim && nvim init.lua'
alias sbr='source ~/.bash_profile'

# ------------------ Shell Utilities ------------------

alias ls='ls --color=auto'
alias la='eza -laghm --all --icons --git --color=always --group-directories-first'
alias ll="eza -l --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons -I '.git|.vscode|node_modules'"
alias l="eza -lah --color=always --group-directories-first --icons"
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias syu='sudo pacman -Syu'
alias e='exit'

# ------------------ Tmux ------------------

alias t='tmux'

# ------------------ Azure ------------------

alias sub='az account set -s'

# ------------------ passwordstore ------------------

alias p='pass'
alias pp='pass git push'
alias pi='pass insert'
alias pmv='pass mv'
alias pcp='pass cp'
alias pedit='pass edit'
alias psearch='pass search'
alias psh='pass show'
alias psc='pass show -c'
alias ppp='pass show -c Sites/canva.com'
alias pbiadmin='pass show -c Sites/microsoftonline.com/hilversum/pbiadmin'

# ------------------ Brew / Updates ------------------

alias update='brew update; brew upgrade; brew upgrade --cask --greedy ; brew cleanup; npm install npm -g; npm update -g;'
alias bdump='brew bundle dump --force --file=$DOTFILES/homebrew/Brewfile'

