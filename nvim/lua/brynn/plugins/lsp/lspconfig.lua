return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			config = function()
				require("typescript-tools").setup({})
			end,
		},
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			-- Remove unused imports keybind
			opts.desc = "Remove unused imports"
			keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>", opts)

			-- Add missing imports keybind
			opts.desc = "Add missing imports"
			keymap.set("n", "<leader>ai", ":TSToolsAddMissing<CR>", opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- Update to use vim.diagnostic.config instead of sign_define (deprecated in nvim 0.12)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
		})

		-- Helper function to setup LSP servers with compatibility
		local function setup_lsp_server(server_name, config)
			config = config or {}
			config.capabilities = capabilities
			config.on_attach = on_attach

			-- Use vim.lsp.config if available (Neovim 0.11+), otherwise use lspconfig
			if vim.lsp.config then
				vim.lsp.config(server_name, config)
				vim.lsp.enable(server_name)
			else
				lspconfig[server_name].setup(config)
			end
		end

		-- configure html server
		setup_lsp_server("html")

		-- configure typescript server
		setup_lsp_server("ts_ls")

		-- configure typescript server with plugin
		require("typescript-tools").setup({
			server = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					tsserver_file_preferences = {
						disableSuggestions = true,
					},
					typescript = {
						tsconfig = "tsconfig.json",
						eslint = true,
						prettier = true,
						importCost = true,
						codeActions = {
							organizeImports = true,
							fixAll = true,
						},
					},
				},
			},
		})

		-- configure css server
		setup_lsp_server("cssls")

		-- configure tailwindcss server
		setup_lsp_server("tailwindcss", {
			settings = {
				tailwindCSS = {
					lint = {
						cssConflict = "warning",
						invalidApply = "warning",
						invalidScreen = "warning",
						invalidVariant = "warning",
						invalidConfigPath = "warning",
						invalidTailwindDirective = "warning",
						recommendedVariantOrder = "warning",
					},
				},
			},
		})

		-- configure svelte server
		setup_lsp_server("svelte")

		-- configure prisma orm server
		setup_lsp_server("prismals")

		-- configure graphql language server
		setup_lsp_server("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- configure emmet language server
		setup_lsp_server("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure python server
		setup_lsp_server("pyright")

		-- configure angular server
		setup_lsp_server("angularls", {
			filetypes = { "typescript", "typescriptreact", "html", "typescript.tsx" },
		})

		-- configure lua server (with special settings)
		setup_lsp_server("lua_ls", {
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- configure go server (only if Go is available)
		if vim.fn.executable("go") == 1 then
			setup_lsp_server("gopls", {
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})
		end

		-- configure mdx server
		setup_lsp_server("mdx_analyzer")

		-- configure marksman server
		setup_lsp_server("marksman")
	end,
}