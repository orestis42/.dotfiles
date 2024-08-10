# Enable Starship prompt
export PATH="$HOME/.cargo/bin:$PATH"
eval "$(starship init bash)"

# Ensure necessary tools are installed (fzf, zoxide, Starship, etc.)
if ! command -v fzf &> /dev/null; then
  echo "fzf not found, please install it."
fi

if ! command -v zoxide &> /dev/null; then
  echo "zoxide not found, please install it."
fi

if ! command -v starship &> /dev/null; then
  echo "Starship not found, please install it."
fi

# Keybindings - only bind if the shell is interactive
if [[ $- == *i* ]]; then
  bind '"\C-p": "\e[A"'
  bind '"\C-n": "\e[B"'
  bind '"\e[1~": beginning-of-line'
  bind '"\e[4~": end-of-line'
  bind '"\e[5~": kill-whole-line'
fi

# History
HISTSIZE=5000
HISTFILE=~/.bash_history
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
shopt -s cmdhist

# Completion settings
if [[ $- == *i* ]]; then
  bind 'set completion-ignore-case on'
  bind 'set show-all-if-ambiguous on'
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias vim='nvim'
alias c="clear"

# Shell integrations
[ -s ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(zoxide init bash)"

# Start ssh-agent if it's not already running
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Add the SSH key if it's not already added
if ! ssh-add -l | grep -q "o.r.e.s.t.i.s@hotmail.com"; then
    ssh-add ~/.ssh/github > /dev/null 2>&1
fi

# Custom functions (if any)
function my_custom_function {
    echo "This is a custom function."
}

# Load custom scripts (if any)
if [ -f ~/.bash_custom ]; then
    source ~/.bash_custom
fi

# Final settings
shopt -s checkwinsize

export PATH=$HOME/.local/bin:$PATH

