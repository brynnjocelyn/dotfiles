# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# Auto attach to tmux session
if [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

# Custom cd and .. commands
function cd() {
  builtin cd "$@" && ls -al # List all files after cd
}
function ..() {
  builtin cd .. && ls -al # List all files after ..
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

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
