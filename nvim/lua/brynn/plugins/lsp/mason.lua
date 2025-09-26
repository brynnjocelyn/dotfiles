return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- Helper function to check if a command exists
      local function command_exists(cmd)
        return vim.fn.executable(cmd) == 1
      end

      -- Build list of available LSP servers based on system capabilities
      local available_servers = {
        "ts_ls",       -- Node.js available
        "html",        -- Built into nvim
        "cssls",       -- Node.js available
        "tailwindcss", -- Node.js available
        "svelte",      -- Node.js available
        "graphql",     -- Node.js available
        "emmet_ls",    -- Node.js available
        "prismals",    -- Node.js available
        "pyright",     -- Python available
        "angularls",   -- Node.js available
        "mdx_analyzer", -- Node.js available
        "marksman",    -- Standalone binary
      }

      -- Add Go-based servers only if Go is available
      if command_exists("go") then
        table.insert(available_servers, "gopls")
      end

      -- Add Lua server only if Lua is available (lua_ls uses built-in Lua)
      -- Note: lua_ls actually bundles its own Lua, so it should work
      table.insert(available_servers, "lua_ls")

      require("mason-lspconfig").setup({
        ensure_installed = available_servers,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- Helper function to check if a command exists
      local function command_exists(cmd)
        return vim.fn.executable(cmd) == 1
      end

      -- Build list of available tools based on system capabilities
      local available_tools = {
        "prettier",      -- Node.js available
        "isort",         -- Python available
        "black",         -- Python available
        "pylint",        -- Python available
        "eslint_d",      -- Node.js available
        "markdownlint",  -- Node.js available
        "jsonlint",      -- Node.js available
        "ansible-lint",  -- Python available
        "hadolint",      -- Standalone binary
      }

      -- Add Go tools only if Go is available
      if command_exists("go") then
        table.insert(available_tools, "goimports")
      end

      -- Add Lua tools only if Lua is available
      if command_exists("lua") then
        table.insert(available_tools, "luacheck")
      end

      -- Note: stylua is a standalone binary that doesn't require Lua runtime
      table.insert(available_tools, "stylua")

      require("mason-tool-installer").setup({
        ensure_installed = available_tools,
      })
    end,
  },
}