return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- Lazy-load on :Copilot command
    event = "InsertEnter", -- Lazy-load when entering insert mode
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- Options: bottom, top, left, right, horizontal, vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false, -- Set to true if you want suggestions to appear automatically
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = "<M-l>", -- Alt-l to accept suggestion
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        auth_provider_url = nil, -- Set to e.g., "https://mycorp.ghe.com/" if using a custom GitHub instance
        logger = {
          file = vim.fn.stdpath("log") .. "/copilot-lua.log",
          file_log_level = vim.log.levels.OFF,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = "off", -- Options: "off", "messages", "verbose"
          trace_lsp_progress = false,
          log_lsp_messages = false,
        },
        copilot_node_command = "node", -- Use node from PATH
        workspace_folders = {}, -- Add paths like "/home/user/projects" if needed
        copilot_model = "", -- Default is gpt-35-turbo; set to "gpt-4o-copilot" if desired
        root_dir = function()
          -- Find .git directory by searching upward from current buffer
          local git_root = vim.fs.find(".git", { upward = true, path = vim.fn.expand("%:p:h") })[1]
          if git_root then
            return vim.fs.dirname(git_root)
          end
          -- Fallback to current working directory if no .git found
          return vim.fn.getcwd()
        end,
        should_attach = function(_, _)
          if not vim.bo.buflisted then
            return false
          end
          if vim.bo.buftype ~= "" then
            return false
          end
          return true
        end,
        server = {
          type = "nodejs", -- Options: "nodejs", "binary"
          custom_server_filepath = nil,
        },
        server_opts_overrides = {
          -- Example override; uncomment and adjust as needed
          -- trace = "verbose",
          -- settings = {
          --   advanced = {
          --     listCount = 10, -- Number of completions for panel
          --     inlineSuggestCount = 3, -- Number of inline completions
          --   },
          -- },
        },
      })
    end,
  },

  -- Optional: Integration with nvim-cmp (LazyVim includes nvim-cmp by default)
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
