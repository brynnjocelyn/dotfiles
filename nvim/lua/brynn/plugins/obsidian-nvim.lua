return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- Only load for markdown files in Obsidian vault directories if they exist
	event = {
		-- Load conditionally based on file path
		"BufReadPre */obsidian/*/**.md",
		"BufNewFile */obsidian/*/**.md",
	},
	-- Use cmd to allow manual loading if needed
	cmd = { "ObsidianOpen", "ObsidianNew", "ObsidianQuickSwitch", "ObsidianSearch" },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "epwalsh/pomo.nvim",
		-- see below for full list of optional dependencies 👇
	},


	config = function()
		-- Check if any Obsidian vaults exist before configuring
		local function get_available_workspaces()
			local workspaces = {}

			-- Check for the main vault
			local main_vault = vim.fn.expand("~/obsidian/brain-vault")
			if vim.fn.isdirectory(main_vault) == 1 then
				table.insert(workspaces, {
					name = "personal",
					path = main_vault,
				})
			end

			-- You can add more vault checks here in the future
			-- Example:
			-- local work_vault = vim.fn.expand("~/work-obsidian")
			-- if vim.fn.isdirectory(work_vault) == 1 then
			--   table.insert(workspaces, { name = "work", path = work_vault })
			-- end

			return workspaces
		end

		local workspaces = get_available_workspaces()

		-- Only setup the plugin if we have at least one valid workspace
		if #workspaces > 0 then
			require("obsidian").setup({
				workspaces = workspaces,

				-- Optional, completion of wiki links, local markdown files, and tags using nvim-cmp.
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},

				-- Define templates for new files (only if main vault exists)
				templates = workspaces[1] and {
					folder = workspaces[1].path .. "/templates",
					date_format = "%Y-%m-%d-%a",
					time_format = "%H:%M",
				} or nil,

				ui = { enable = false },
			})
		else
			-- Graceful fallback: create a minimal setup or disable the plugin
			vim.notify("Obsidian.nvim: No valid vault directories found. Plugin disabled.", vim.log.levels.WARN)
		end
	end,
}
