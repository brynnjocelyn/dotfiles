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
			local configs = require("nvim-treesitter.configs")

			-- configure treesitter
			configs.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
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
				},

				-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
				require("ts_context_commentstring").setup({}),

				-- auto install above language parsers
				auto_install = true,
			})
			-- use 'markdown' parser for 'mdx' files
			local ft_to_parser = require("nvim-treesitter.parsers").ft_to_lang("mdx")
			-- print("ft_to_parser result => ", ft_to_parser)

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			-- print("parser_config => ", parser_config)
			--[[ for k, v in pairs(parser_config) do
				print(k, v)
			end ]]
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
