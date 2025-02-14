# Enable Starship prompt
eval "$(starship init zsh)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
# Commenting out the command-not-found snippet to avoid errors
# zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ll='ls -lah --color'
alias vim='nvim'
alias c="clear"
alias nix-shell="nix-shell --run zsh"

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Start ssh-agent if it's not already running
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Add the SSH key if it's not already added
if ! ssh-add -l | grep -q "o.r.e.s.t.i.s@hotmail.com"; then
    ssh-add ~/.ssh/github > /dev/null 2>&1
fi

# Suppress Powerlevel10k warning (no longer needed for Starship)
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Resolve DBI errors by checking if nixos database exists
if [ -f /nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite ]; then
  zinit snippet OMZP::command-not-found
fi

export PATH="/opt/avr8-gnu-toolchain_linu_x86_64/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/orestis/.lmstudio/bin"

# opam configuration
[[ ! -r /home/orestis/.opam/opam-init/init.zsh ]] || source /home/orestis/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
