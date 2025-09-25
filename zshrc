# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Ensure UTF-8
export LANG=en_US.UTF-8

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Enable completion dots for feedback
COMPLETION_WAITING_DOTS="true"

# Initialize plugin sources based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific settings
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  # Linux specific settings for autosuggestions and syntax highlighting
  if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi
  if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
fi

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(git vi-mode virtualenv sudo web-search)

# User-defined aliases and PATH additions
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# Additional PATH settings based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific paths
  export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
  export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"
  export PATH="/Applications/Tailscale.app/Contents/MacOS:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific paths
  export PATH="$HOME/.local/bin:$PATH"
fi

# Set up NVM if installed
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Angular CLI autocompletion if ng command is available
command -v ng &>/dev/null && source <(ng completion script)

# Google Cloud SDK setup if available
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Environment manager if available
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Set JAVA_HOME for macOS (you might want to adjust version and path)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi

# Auto attach to tmux session (macOS only)
# Only auto-launch on macOS to avoid nested tmux sessions when SSHing from Mac to Linux servers.
# Nested tmux sessions cause issues with copy/paste and keybinding contexts.
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi
fi

# Custom cd and .. commands
function cd() {
  builtin cd "$@" && ls -al # List all files after cd
}
function ..() {
  builtin cd .. && ls -al # List all files after ..
}

# SSH wrapper function for tmux pane name switching
# Function to handle SSH and update tmux pane name automatically
ssh() {
    # Check if we're in tmux
    if [[ -n "$TMUX" ]]; then
        # Save current pane title
        local old_name=$(tmux display-message -p '#{pane_title}')
        
        # Extract hostname from SSH command (handles user@host and host formats)
        local ssh_host=$(echo "$@" | grep -oE '([^@\s]+@)?[^@\s]+(\s|$)' | head -1 | sed 's/.*@//; s/[[:space:]]*$//')
        
        # Set pane title to hostname
        tmux select-pane -T "$ssh_host"
        
        # Run SSH command
        command ssh "$@"
        
        # Restore original pane title after SSH exits
        tmux select-pane -T "$old_name"
    else
        # Not in tmux, just run SSH normally
        command ssh "$@"
    fi
}

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History configuration
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# Key bindings for history navigation
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

#ALIAS
alias gst="git status"
alias gco="git checkout"
alias gaa="git add --all"
alias gus="git restore --staged" #Git Unstage followed by file name(s)

alias ssha="eval $(ssh-agent) && ssh-add"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

# Additional PATH exports
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Python environment management with pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Claude Code configuration
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=32000
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/brynnjknight/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
