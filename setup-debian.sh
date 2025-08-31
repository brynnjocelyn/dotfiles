#!/bin/bash

# Automated Debian Development Environment Setup Script
# Last Updated On: August 31, 2025
# Author: Generated from dotfiles analysis
# Usage: curl -fsSL <raw-script-url> | bash
# Or: ./setup-debian.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Debian/Ubuntu
check_system() {
    if [[ ! -f /etc/debian_version ]]; then
        log_error "This script is designed for Debian-based systems only"
        exit 1
    fi
    log_success "Debian-based system detected"
}

# Update system
update_system() {
    log_info "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    log_success "System packages updated"
}

# Install core tools
install_core_tools() {
    log_info "Installing core development tools..."
    sudo apt install -y \
        curl wget git build-essential cmake pkg-config \
        libtool autoconf automake unzip tar gzip \
        ripgrep fd-find fzf bat exa tmux zsh \
        python3 python3-pip python3-venv python3-dev \
        luajit luarocks cargo rustc \
        zsh-autosuggestions zsh-syntax-highlighting

    # Create fd symlink
    sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
    
    log_success "Core tools installed"
}

# Install Node.js via nvm
install_nodejs() {
    log_info "Installing Node.js via nvm..."
    
    # Install nvm
    if [[ ! -d "$HOME/.nvm" ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        nvm alias default node
        
        log_success "Node.js installed via nvm"
    else
        log_warning "nvm already installed, skipping"
    fi
}

# Install Go
install_go() {
    log_info "Installing Go..."
    
    if ! command -v go &> /dev/null; then
        GO_VERSION="1.21.6"
        wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
        rm go${GO_VERSION}.linux-amd64.tar.gz
        
        # Add to PATH
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
        export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
        
        log_success "Go installed"
    else
        log_warning "Go already installed, skipping"
    fi
}

# Install Neovim
install_neovim() {
    log_info "Installing latest Neovim..."
    
    # Download and install Neovim AppImage
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    sudo ln -sf /usr/local/bin/nvim /usr/local/bin/vim
    
    log_success "Neovim installed"
}

# Install Oh-My-Zsh
install_ohmyzsh() {
    log_info "Installing Oh-My-Zsh..."
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        # Install Oh-My-Zsh non-interactively
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        
        # Install Powerlevel10k theme
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        
        log_success "Oh-My-Zsh and Powerlevel10k installed"
    else
        log_warning "Oh-My-Zsh already installed, skipping"
    fi
}

# Install LazyGit
install_lazygit() {
    log_info "Installing LazyGit..."
    
    if ! command -v lazygit &> /dev/null; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit.tar.gz lazygit
        
        log_success "LazyGit installed"
    else
        log_warning "LazyGit already installed, skipping"
    fi
}

# Install fonts
install_fonts() {
    log_info "Installing Nerd Fonts..."
    
    # Create fonts directory
    mkdir -p ~/.local/share/fonts
    
    # Download MesloLGS Nerd Font if not exists
    if [[ ! -f ~/.local/share/fonts/MesloLGSNerdFont-Regular.ttf ]]; then
        cd ~/.local/share/fonts
        wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
        unzip -q Meslo.zip
        rm Meslo.zip
        
        # Refresh font cache
        fc-cache -fv > /dev/null
        
        log_success "Nerd Fonts installed"
    else
        log_warning "Nerd Fonts already installed, skipping"
    fi
}

# Setup dotfiles
setup_dotfiles() {
    log_info "Setting up dotfiles..."
    
    # Create dotfiles directory if it doesn't exist
    if [[ ! -d ~/dotfiles ]]; then
        log_warning "dotfiles directory not found. Please clone your dotfiles repository to ~/dotfiles"
        log_info "You can do this manually with: git clone <your-repo-url> ~/dotfiles"
        return
    fi
    
    # Create config directory
    mkdir -p ~/.config
    
    # Create symlinks
    declare -A dotfiles=(
        ["~/dotfiles/zshrc"]="~/.zshrc"
        ["~/dotfiles/tmux.conf"]="~/.tmux.conf"
        ["~/dotfiles/vimrc"]="~/.vimrc"
        ["~/dotfiles/taskrc"]="~/.taskrc"
        ["~/dotfiles/nvim"]="~/.config/nvim"
        ["~/dotfiles/wezterm"]="~/.config/wezterm"
    )
    
    for source in "${!dotfiles[@]}"; do
        target="${dotfiles[$source]}"
        source_expanded=$(eval echo $source)
        target_expanded=$(eval echo $target)
        
        if [[ -e "$source_expanded" ]]; then
            # Remove existing file/symlink
            rm -rf "$target_expanded"
            # Create symlink
            ln -sf "$source_expanded" "$target_expanded"
            log_success "Symlinked $source -> $target"
        else
            log_warning "Source file $source not found, skipping"
        fi
    done
}

# Install global npm packages
install_npm_packages() {
    log_info "Installing global npm packages..."
    
    # Source nvm to make sure npm is available
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    if command -v npm &> /dev/null; then
        npm install -g \
            typescript \
            typescript-language-server \
            vscode-langservers-extracted \
            @angular/language-server \
            prettier \
            eslint_d \
            markdownlint-cli \
            jsonlint
        
        log_success "Global npm packages installed"
    else
        log_warning "npm not found, skipping global package installation"
    fi
}

# Change default shell
change_shell() {
    log_info "Setting Zsh as default shell..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        sudo chsh -s $(which zsh) $USER
        log_success "Default shell changed to Zsh (restart required)"
    else
        log_warning "Zsh already set as default shell"
    fi
}

# Create verification script
create_verification_script() {
    log_info "Creating verification script..."
    
    cat > ~/verify-setup.sh << 'EOF'
#!/bin/bash
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
EOF

    chmod +x ~/verify-setup.sh
    log_success "Verification script created at ~/verify-setup.sh"
}

# Main installation function
main() {
    log_info "Starting Debian Development Environment Setup..."
    
    check_system
    update_system
    install_core_tools
    install_nodejs
    install_go
    install_neovim
    install_ohmyzsh
    install_lazygit
    install_fonts
    install_npm_packages
    setup_dotfiles
    change_shell
    create_verification_script
    
    log_success "Installation completed!"
    log_info "Next steps:"
    echo "1. Clone your dotfiles repository to ~/dotfiles if not done already"
    echo "2. Run ~/verify-setup.sh to verify the installation"
    echo "3. Log out and log back in (or restart) to use Zsh as default shell"
    echo "4. Start Neovim and run :Lazy install followed by :Mason to complete plugin setup"
    echo "5. Run p10k configure to set up your Powerlevel10k theme"
    
    log_info "Installation log complete. Have a great day coding! 🚀"
}

# Run main function
main "$@"