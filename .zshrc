# Set the default shell options
export ZSH=$HOME
HISTFILE=$ZSH/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Set Vim mode
set -o vi
export KEYTIMEOUT=1

# Enable command auto-completion
autoload -Uz compinit
compinit

# Check if 'menuselect' keymap is available, then set bindings
if (( ${+widgets[menu-select]} )); then
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
fi

# Enhanced prompt with special characters
autoload -U colors && colors
setopt PROMPT_SUBST
PROMPT='%F{cyan}%n@%m %F{magenta}-> %1~ %F{green}$(git_branch)%F{none}
%F{green}$%f '

# Function to get current git branch in a clean format with a special character
git_branch() {
  local branch
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  [[ -n $branch ]] && echo "%F{red} $branch%f "
}

# Aliases for convenience and speed
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Git aliases for quick command execution
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Source syntax highlighting if it exists
if [ -d "$HOME/.zsh-syntax-highlighting" ]; then
  source "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

