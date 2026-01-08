return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- ensure these language parsers are installed
			local ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"gitignore",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"prisma",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			}

			-- Install parsers (only if not already installed)
			local ts = require("nvim-treesitter")
			for _, lang in ipairs(ensure_installed) do
				if not pcall(vim.treesitter.language.inspect, lang) then
					pcall(ts.install, { lang })
				end
			end

			-- Enable treesitter highlighting and indentation
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			require("ts_context_commentstring").setup({})

			-- use 'markdown' parser for 'mdx' files
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
