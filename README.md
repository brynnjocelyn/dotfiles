# 🏠 Brynn's Dotfiles

> Personal configuration files for a productive development environment

## 📦 What's Inside

This repository contains configuration files for my development setup:

- 🚀 **Neovim** - Text editor with IDE-like capabilities
- 📊 **Tmux** - Terminal multiplexer for managing sessions
- 🐚 **Zsh** - Shell with Oh My Zsh framework
- 🖥️ **Wezterm** - GPU-accelerated terminal emulator
- 📝 **Vim** - Classic text editor (legacy configuration)
- ✅ **Taskwarrior** - Task management tool

## ⚙️ Configuration Highlights

### Neovim Configuration

- 🔌 Plugin management with lazy.nvim
- 🌈 Beautiful UI with modern colorschemes
- 🧠 Intelligent code completion via nvim-cmp
- 🔍 Fuzzy finding with Telescope
- 🌲 File navigation with nvim-tree
- 🔤 Syntax highlighting with Treesitter
- 🛠️ LSP support for multiple languages
- 📝 Markdown and Obsidian integration
- 🔄 Git integration with Fugitive and Gitsigns

### Tmux Configuration

- 🎮 Custom keybindings with C-Space as prefix
- 🖱️ Mouse support enabled
- 🧭 Vim-style navigation
- 🎨 Dracula theme for status bar
- 💾 Session persistence with tmux-resurrect
- 🔄 Continuous saving with tmux-continuum
- ⚡ Integration with Vim/Neovim for seamless navigation

### Zsh Configuration

- 💻 Powerlevel10k theme
- 🔄 Auto-suggestions and syntax highlighting
- 🚀 Useful aliases for git and other tools
- 🌐 Cross-platform support (macOS and Linux)
- 🔐 SSH agent helper alias

### Wezterm Configuration

- 🎨 Catppuccin Mocha theme
- 🔤 MesloLGS Nerd Font
- 🪟 Custom transparency settings
- 📜 Increased scrollback buffer

## 🚀 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/brynnjocelyn/dotfiles.git ~/.dotfiles
   ```

2. Create symbolic links:
   ```bash
   ln -s ~/.dotfiles/zshrc ~/.zshrc
   ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
   ln -s ~/.dotfiles/nvim ~/.config/nvim
   ln -s ~/.dotfiles/wezterm ~/.config/wezterm
   ln -s ~/.dotfiles/vimrc ~/.vimrc
   ln -s ~/.dotfiles/taskrc ~/.taskrc
   ```

## 🖥️ Development Environment

This configuration works best with:

- **Terminal**: Wezterm
- **Shell**: Zsh with Oh My Zsh
- **Session Manager**: Tmux
- **Editor**: Neovim
- **Font**: MesloLGS Nerd Font

## ⚡ Key Bindings

### Neovim

- **Leader Key**: Space
- `<leader>ff`: Find files
- `<leader>fg`: Find text in files
- `<leader>nt`: Toggle file explorer
- `<leader>uu`: Toggle undotree
- `<leader>lu`: Update plugins
- `<leader>ww`: Save file
- `<leader>q`: Quit

Full keybindings can be viewed with `<leader>?` in Neovim.

### Tmux

- **Prefix**: C-Space
- `<prefix> r`: Reload configuration
- `<prefix> |`: Split vertically
- `<prefix> -`: Split horizontally
- `<prefix> h/j/k/l`: Navigate panes
- `<prefix> H/J/K/L`: Resize panes
- `<prefix> s/j`: Send/join panes

## 🛠️ Maintenance

This repo is continuously updated with new configurations and improvements. Key commands:

- Update Neovim plugins: `<leader>lu` in Neovim
- Update Tmux plugins: `<prefix> U` in Tmux
- Update Oh My Zsh: `omz update` in terminal

## 🔄 Cross-Platform Support

Configurations include conditional logic to work on both macOS and Linux systems.

## 📜 License

This project is open source and available under the [MIT License](LICENSE).