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
		-- Note: lspconfig utility functions are no longer needed with vim.lsp.config
		-- The new API handles root directory detection automatically

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		-- Use LspAttach autocmd to set up keybindings when LSP attaches to buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local bufnr = ev.buf
				local opts = { noremap = true, silent = true, buffer = bufnr }

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

				-- TypeScript-specific keybinds (only set for typescript-tools client)
				if client.name == "typescript-tools" then
					-- Remove unused imports keybind
					opts.desc = "Remove unused imports"
					keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>", opts)

					-- Add missing imports keybind
					opts.desc = "Add missing imports"
					keymap.set("n", "<leader>ai", ":TSToolsAddMissing<CR>", opts)
				end
			end,
		})

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

		-- configure html server
		vim.lsp.config('html', {
			capabilities = capabilities,
		})
		vim.lsp.enable('html')

		-- configure typescript server
		vim.lsp.config('ts_ls', {
			capabilities = capabilities,
		})
		vim.lsp.enable('ts_ls')

		-- configure typescript-tools plugin (enhanced TypeScript support)
		require("typescript-tools").setup({
			server = {
				capabilities = capabilities,
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
		vim.lsp.config('cssls', {
			capabilities = capabilities,
		})
		vim.lsp.enable('cssls')

		-- configure tailwindcss server
		vim.lsp.config('tailwindcss', {
			capabilities = capabilities,
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
		vim.lsp.enable('tailwindcss')

		-- configure svelte server
		vim.lsp.config('svelte', {
			capabilities = capabilities,
		})
		vim.lsp.enable('svelte')

		-- configure prisma orm server
		vim.lsp.config('prismals', {
			capabilities = capabilities,
		})
		vim.lsp.enable('prismals')

		-- configure graphql language server
		vim.lsp.config('graphql', {
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})
		vim.lsp.enable('graphql')

		-- configure emmet language server
		vim.lsp.config('emmet_ls', {
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})
		vim.lsp.enable('emmet_ls')

		-- configure python server
		vim.lsp.config('pyright', {
			capabilities = capabilities,
		})
		vim.lsp.enable('pyright')

		-- configure angular server
		vim.lsp.config('angularls', {
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "html", "typescript.tsx" },
		})
		vim.lsp.enable('angularls')

		-- configure lua server (with special settings)
		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
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
		vim.lsp.enable('lua_ls')

		-- configure go server
		vim.lsp.config('gopls', {
			capabilities = capabilities,
			cmd = { "gopls", "serve" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
		vim.lsp.enable('gopls')

		-- configure mdx server
		vim.lsp.config('mdx_analyzer', {
			capabilities = capabilities,
		})
		vim.lsp.enable('mdx_analyzer')

		-- configure marksman server
		vim.lsp.config('marksman', {
			capabilities = capabilities,
		})
		vim.lsp.enable('marksman')
	end,
}