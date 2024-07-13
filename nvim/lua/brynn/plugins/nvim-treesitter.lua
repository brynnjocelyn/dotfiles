return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"prisma",
					"markdown",
					"mdx",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
				},

				-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
				require("ts_context_commentstring").setup({}),

				-- auto install above language parsers
				auto_install = true,
			})
			-- use 'markdown' parser for 'mdx' files
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.mdx = {
				install_info = {
					url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "main",
				},
				filetype = "mdx",
			}
		end,
	},
}
