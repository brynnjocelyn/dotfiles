# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This repository contains dotfiles for:

1. **Neovim** (`nvim/`) - A highly customized Neovim setup using lazy.nvim for plugin management
2. **Tmux** (`tmux.conf`) - Terminal multiplexer configuration
3. **Zsh** (`zshrc`) - Shell configuration with oh-my-zsh
4. **Wezterm** (`wezterm/wezterm.lua`) - Terminal emulator configuration
5. **Vim** (`vimrc`) - Classic Vim configuration (appears to be legacy, as Neovim is the primary editor)
6. **Taskwarrior** (`taskrc`) - Task management tool

## Maintenance Notes

- Neovim 0.11+ deprecation notices have been addressed in the core configuration
- Some third-party plugins may still show deprecation warnings that will be fixed by the plugin maintainers
- Updated diagnostic sign configuration to use `vim.diagnostic.config()` instead of `vim.fn.sign_define()` in `lspconfig.lua:85-94`

## Neovim Configuration Architecture

The Neovim configuration follows a modular lazy-loading structure:

### Core Architecture
- `init.lua` - Entry point that loads `brynn.core` and `brynn.lazy` modules
- `lua/brynn/core/init.lua` - Loads all core modules in order
- `lua/brynn/lazy.lua` - Bootstraps lazy.nvim and imports plugin configurations
- `lua/brynn/plugins/` - Individual plugin configurations (each returns a lazy.nvim spec)
- `lua/brynn/plugins/lsp/` - Language Server Protocol configurations

### Key Design Patterns
- Each plugin is configured in its own file that returns a lazy.nvim table specification
- LSP configurations use a common `on_attach` function for consistent keybindings across all language servers
- Formatters and linters are configured through conform.nvim and nvim-lint respectively
- All keybindings use descriptive `desc` fields for which-key integration
- Plugin loading is deferred using lazy.nvim events (`BufReadPre`, `BufNewFile`, etc.)

### Important Configuration Details
- Uses typescript-tools.nvim instead of built-in TypeScript LSP for enhanced functionality
- LSP keybindings are set both globally in `keymaps.lua` and per-buffer in `lspconfig.lua`
- Diagnostic signs use modern `vim.diagnostic.config()` API (not deprecated `sign_define`)
- Format-on-save is enabled through conform.nvim with 500ms timeout

## Common Commands

### Neovim

- Update plugins: `:Lazy update` or `<leader>lu`
- Install plugins: `:Lazy install` or `<leader>li`
- Manage files:
  - Find files: `<leader>ff`
  - Find in files: `<leader>fs` (live_grep)
  - Recent files: `<leader>fr`
  - Find string under cursor: `<leader>fc`
  - Find buffers: `<leader>fb`
- LSP commands:
  - Restart LSP: `:LspRestart` or `<leader>rs`
  - Code actions: `<leader>ca`
  - Go to definition: `gd`
  - Find references: `gR`
  - Rename symbol: `<leader>rn`
  - Show line diagnostics: `<leader>d`
  - Add missing imports: `<leader>ai` (TypeScript only)
  - Remove unused imports: `<leader>ru` (TypeScript only)
  - Manual linting: `<leader>l`
- File formatting: `<leader>mp` (Format file or range via conform.nvim)
- File explorer: `<leader>nt` (Toggle NvimTree)
- Window management:
  - Split vertically: `<leader>sv`
  - Split horizontally: `<leader>sh`
  - Close split: `<leader>sx`
- File operations:
  - Save: `<leader>ww`
  - Save all: `<leader>wa`
  - Quit: `<leader>q`
  - Quit all: `<leader>qq`
- Common plugins:
  - UndoTree: `<leader>uu`
  - Markdown Preview: `<leader>mp`
  - Obsidian: `<leader>o[n,o,s,t]` (New, Open, Search, Template)
  - TailwindCSS: `<leader>ts` (Sort classes)

### Development Languages

The Neovim configuration includes LSP support for:

- TypeScript/JavaScript
- HTML/CSS
- Tailwind CSS
- Svelte
- Lua
- GraphQL
- Prisma
- Python
- Angular
- Go
- Markdown/MDX

Formatter and linter support includes:

- Prettier
- ESLint
- StyLua
- Black/isort (Python)
- goimports (Go)
- markdownlint
- luacheck

## Keybinding System

The configuration uses space as the leader key. Common patterns:

- `<leader>f*` - File operations
- `<leader>g*` - Git operations
- `<leader>l*` - LSP operations
- `<leader>n*` - NvimTree operations
- `<leader>t*` - Tab operations
- `<leader>w*` - Write operations
- `<leader>q*` - Quit operations

To see all available keymaps: `<leader>?`

## Common Development Workflows

### Plugin Management
- Check plugin status: `:Lazy` 
- Update specific plugin: `:Lazy update <plugin-name>`
- Clean unused plugins: `:Lazy clean`
- Profile startup time: `:Lazy profile`

### LSP Troubleshooting
- Check LSP status: `:LspInfo`
- View LSP logs: `:LspLog` 
- Restart specific LSP: `:LspRestart <server-name>`
- Check Mason-installed tools: `:Mason`

### Format/Lint Workflow
- Auto-format on save is enabled via conform.nvim
- Manual format: `<leader>mp`
- Manual lint: `<leader>l`
- Check conform status: `:ConformInfo`

### Configuration Reloading
- Source init.lua: `<leader>so` 
- Reload current file: `<leader>rl`

### File Navigation Patterns
- Use `<leader>ff` for fuzzy file finding
- Use `<leader>fs` for content search across files
- Use `<leader>fb` for open buffer navigation
- Use `<leader>nt` to toggle file tree when needed

