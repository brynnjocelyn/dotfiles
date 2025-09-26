# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Commands

### Configuration Development
- **Reload configuration**: `<leader>so` (sources init.lua) or `<leader>rl` (reloads current file)
- **Check for errors**: `:checkhealth` (general health check) or `:checkhealth <plugin>` (specific plugin)
- **Debug plugin loading**: `:Lazy profile` (shows startup times for each plugin)
- **Test LSP setup**: `:LspInfo` (shows active LSP clients and their status)

### Plugin Development Workflow
When adding or modifying plugins:
1. Create/edit plugin file in `lua/brynn/plugins/` following the existing pattern
2. Reload with `:Lazy reload <plugin-name>` or restart Neovim
3. Install new plugins with `:Lazy install`
4. Check for errors with `:messages`

### Adding New Language Support
1. Add LSP server to `available_servers` list in `lua/brynn/plugins/lsp/mason.lua`
2. Configure server in `lua/brynn/plugins/lsp/lspconfig.lua` (most use default config)
3. Add formatters/linters to `available_tools` list in mason-tool-installer section
4. Configure formatter in `formatting.lua` and linter in `linting.lua`
5. Run `:MasonInstallAll` to install new tools

**Note**: The configuration automatically detects available system dependencies (Go, Lua, etc.) and only installs compatible tools to avoid installation failures.

## High-Level Architecture

### Plugin Loading Strategy
The configuration uses lazy.nvim's event-based loading to optimize startup time:
- **Immediate**: Core settings, colorscheme
- **VeryLazy**: UI enhancements (lualine, bufferline)
- **BufReadPre/BufNewFile**: File-specific tools (LSP, treesitter, formatting)
- **InsertEnter**: Completion and snippets
- **Cmd**: Command-specific plugins (UndoTree, Lazy itself)

### LSP Integration Pattern
All LSP servers share a common configuration pattern (Neovim 0.11+):
```lua
vim.lsp.config(server_name, {
  capabilities = capabilities,  -- from cmp_nvim_lsp
  on_attach = on_attach,       -- common keybindings function
  -- server-specific settings here
})
vim.lsp.enable(server_name)
```

For backwards compatibility with Neovim 0.10 and earlier, a helper function handles both APIs:
```lua
local function setup_lsp_server(server_name, config)
  config = config or {}
  config.capabilities = capabilities
  config.on_attach = on_attach

  if vim.lsp.config then
    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
  else
    require('lspconfig')[server_name].setup(config)
  end
end
```

The `on_attach` function (lspconfig.lua:10-77) sets up buffer-local keybindings that are consistent across all language servers.

### Configuration Modularity
Each plugin configuration is self-contained:
- Returns a lazy.nvim specification table
- Includes all dependencies
- Sets up keybindings within the config function
- Uses consistent keybinding patterns (leader + mnemonic prefix)

### State Management
- **Sessions**: Auto-session saves/restores workspace state
- **Undo History**: Persistent undo via undodir setting
- **Plugin State**: Managed by lazy.nvim in `~/.local/share/nvim/lazy/`

### Error Handling Patterns
- Plugins use `pcall` or lazy.nvim's built-in error handling
- LSP errors appear in diagnostics (view with `<leader>d`)
- Plugin errors visible in `:messages` or `:Lazy log`

## Development Tips

### Performance Optimization
- Use `:Lazy profile` to identify slow plugins
- Defer plugin loading with appropriate events
- Use `keys` in lazy specs for command-specific plugins

### Debugging LSP Issues
1. Check server status: `:LspInfo`
2. View logs: `:LspLog`
3. Test server manually: `:lua =vim.lsp.get_active_clients()`
4. Verify Mason installation: `:Mason` then press `i` on a server

### Managing Keybinding Conflicts
- Use `:verbose map <key>` to find what's mapped to a key
- Check which-key with `<leader>?` for available mappings
- Plugin keymaps are defined in their respective config files

### Configuration Testing
While there's no formal test suite, verify changes by:
1. Restarting Neovim and checking `:messages` for errors
2. Running `:checkhealth` for general issues
3. Testing specific functionality manually
4. Using `:Lazy profile` to ensure performance isn't degraded