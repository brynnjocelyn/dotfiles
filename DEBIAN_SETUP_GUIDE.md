# Complete Neovim Development Environment Setup for Debian Linux

**Last Updated On:** August 31, 2025

This guide provides step-by-step instructions to replicate a complete terminal-based development environment on Debian Linux, including Neovim with comprehensive LSP support, Zsh with Oh-My-Zsh, Tmux, and WezTerm terminal emulator.

## Table of Contents

1. [System Prerequisites](#system-prerequisites)
2. [Core System Tools](#core-system-tools)
3. [Terminal Environment Setup](#terminal-environment-setup)
4. [Neovim Installation](#neovim-installation)
5. [Node.js and Python Setup](#nodejs-and-python-setup)
6. [Dotfiles Repository Setup](#dotfiles-repository-setup)
7. [Neovim Configuration](#neovim-configuration)
8. [Additional Tools](#additional-tools)
9. [Font Installation](#font-installation)
10. [Verification Steps](#verification-steps)
11. [Troubleshooting](#troubleshooting)

## System Prerequisites

Update your Debian system:
```bash
sudo apt update && sudo apt upgrade -y
```

## Core System Tools

Install essential development tools and dependencies:

```bash
# Essential build tools
sudo apt install -y \
    curl \
    wget \
    git \
    build-essential \
    cmake \
    pkg-config \
    libtool \
    autoconf \
    automake \
    unzip \
    tar \
    gzip

# Search and file management tools
sudo apt install -y \
    ripgrep \
    fd-find \
    fzf \
    bat \
    exa

# Create symlink for fd-find (Debian packages it as fdfind)
sudo ln -sf $(which fdfind) /usr/local/bin/fd
```

## Terminal Environment Setup

### Install Zsh and Oh-My-Zsh

```bash
# Install Zsh
sudo apt install -y zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change default shell to Zsh
sudo chsh -s $(which zsh) $USER
```

### Install Zsh Plugins

```bash
# Zsh Autosuggestions
sudo apt install -y zsh-autosuggestions

# Zsh Syntax Highlighting  
sudo apt install -y zsh-syntax-highlighting

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Install Tmux

```bash
sudo apt install -y tmux

# Optional: Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Neovim Installation

### Install Neovim (Latest Stable)

```bash
# Download and install latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Alternative: Install via apt (may be older version)
# sudo apt install -y neovim

# Create symlink for vim command
sudo ln -sf /usr/local/bin/nvim /usr/local/bin/vim
```

## Node.js and Python Setup

### Install Node.js (via Node Version Manager)

```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Reload shell or source nvm
source ~/.bashrc

# Install latest LTS Node.js
nvm install --lts
nvm use --lts
nvm alias default node
```

### Install Python and Pip

```bash
# Install Python and development tools
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev

# Create symlinks for convenience
sudo ln -sf /usr/bin/python3 /usr/local/bin/python
sudo ln -sf /usr/bin/pip3 /usr/local/bin/pip
```

### Install Go (for Go formatters)

```bash
# Download and install Go
GO_VERSION="1.21.6"
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz

# Add Go to PATH (add to your shell config)
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
```

## Dotfiles Repository Setup

### Clone and Setup Dotfiles

```bash
# Clone your dotfiles repository
git clone <your-dotfiles-repo-url> ~/dotfiles

# Or if you don't have a repo yet, create the directory structure
mkdir -p ~/dotfiles

# Create symlinks to configuration files
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/taskrc ~/.taskrc

# Create config directory and symlink Neovim config
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Create wezterm config symlink
ln -sf ~/dotfiles/wezterm ~/.config/wezterm
```

### Copy Configuration Files

If you don't have the dotfiles yet, copy them from your macOS system:

```bash
# From your macOS system, create a tarball of the dotfiles
tar -czf dotfiles.tar.gz -C ~ dotfiles

# Transfer to Debian system (via scp, rsync, or other method)
scp dotfiles.tar.gz user@debian-server:~

# On Debian system, extract and setup
tar -xzf dotfiles.tar.gz
# Then follow the symlink setup above
```

## Neovim Configuration

### Install lazy.nvim Plugin Manager

The configuration uses lazy.nvim which will auto-install on first run. However, you can verify the setup:

```bash
# Start Neovim (it will automatically install lazy.nvim and plugins)
nvim

# Inside Neovim, run these commands:
# :Lazy install
# :Mason
# :MasonInstallAll
```

### Install Mason Dependencies

Some tools need to be pre-installed for Mason to work properly:

```bash
# Additional dependencies for various language servers and tools
sudo apt install -y \
    luajit \
    luarocks \
    cargo \
    rustc

# Install global npm packages that may be needed
npm install -g \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    @angular/language-server \
    prettier \
    eslint_d \
    markdownlint-cli \
    jsonlint
```

## Additional Tools

### Install LazyGit

```bash
# Download and install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
```

### Install WezTerm (Optional Terminal Emulator)

```bash
# Add WezTerm GPG key
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg

# Add WezTerm repository  
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

# Update and install
sudo apt update
sudo apt install -y wezterm
```

## Font Installation

### Install Nerd Fonts

The configuration expects MesloLGS Nerd Font. Install it:

```bash
# Create fonts directory
mkdir -p ~/.local/share/fonts

# Download MesloLGS Nerd Font
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
unzip Meslo.zip
rm Meslo.zip

# Refresh font cache
fc-cache -fv
```

## Verification Steps

### Verify Core Tools

```bash
# Verify all tools are installed correctly
echo "=== Verifying Installation ==="
echo "Git: $(git --version)"
echo "Neovim: $(nvim --version | head -1)"
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Python: $(python --version)"
echo "pip: $(pip --version)"
echo "Go: $(go version)"
echo "Ripgrep: $(rg --version | head -1)"
echo "fd: $(fd --version)"
echo "fzf: $(fzf --version)"
echo "LazyGit: $(lazygit --version)"
echo "Tmux: $(tmux -V)"
echo "Zsh: $(zsh --version)"
```

### Test Neovim Setup

```bash
# Start Neovim and check health
nvim +checkhealth

# Verify plugins loaded correctly
nvim +'Lazy health' +qa

# Test Mason installations
nvim +'MasonLog' +qa
```

## Troubleshooting

### Common Issues and Solutions

#### Permission Issues with npm
```bash
# Fix npm permissions
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

#### Mason Tool Installation Failures
```bash
# Ensure all dependencies are met
sudo apt install -y python3-venv nodejs npm cargo
# Retry installation in Neovim
nvim +'MasonInstallAll' +qa
```

#### Fonts Not Displaying Correctly
```bash
# Verify font installation
fc-list | grep -i meslo
# If empty, reinstall fonts and refresh cache
fc-cache -fv
```

#### Zsh Theme Not Loading
```bash
# Ensure Powerlevel10k is properly installed
ls -la ~/.oh-my-zsh/custom/themes/
# Run p10k configure to set up theme
p10k configure
```

#### Telescope Live Grep Not Working
```bash
# Verify ripgrep is installed and accessible
which rg
rg --version
# If missing, reinstall:
sudo apt install ripgrep
```

#### LSP Servers Not Starting
```bash
# Check Mason installation log
nvim +'MasonLog' +qa
# Manually install failed servers
nvim +Mason
# Navigate to server and press 'i' to install
```

### Performance Optimization

```bash
# For better performance on slower systems
echo "=== Optimizing for Performance ==="

# Increase Neovim swap file settings
echo 'set updatetime=300' >> ~/.vimrc
echo 'set timeoutlen=500' >> ~/.vimrc

# Optimize shell startup
echo 'skip_global_compinit=1' >> ~/.zshrc
```

## Environment Verification Script

Create a verification script to ensure everything is working:

```bash
#!/bin/bash
# Save as ~/verify-setup.sh
echo "=== Development Environment Verification ==="

# Check basic tools
tools=("git" "nvim" "node" "python" "go" "rg" "fd" "fzf" "lazygit" "tmux" "zsh")
for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "✅ $tool: $(command -v $tool)"
    else
        echo "❌ $tool: NOT FOUND"
    fi
done

# Check Neovim config
if [ -L ~/.config/nvim ]; then
    echo "✅ Neovim config: Symlinked to $(readlink ~/.config/nvim)"
else
    echo "❌ Neovim config: Not properly symlinked"
fi

# Check dotfiles
dotfiles=(".zshrc" ".tmux.conf" ".vimrc")
for file in "${dotfiles[@]}"; do
    if [ -L ~/"$file" ]; then
        echo "✅ $file: Symlinked to $(readlink ~/$file)"
    else
        echo "❌ $file: Not symlinked"
    fi
done

echo "=== Verification Complete ==="
```

Make it executable:
```bash
chmod +x ~/verify-setup.sh
./verify-setup.sh
```

This guide provides a complete, step-by-step setup that should replicate your macOS Neovim development environment on Debian Linux with all necessary dependencies and tools.