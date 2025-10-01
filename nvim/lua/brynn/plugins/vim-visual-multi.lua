-- Vim Visual Multi
-- see: https://github.com/mg979/vim-visual-multi
-- docs: :h vm
return {
	"mg979/vim-visual-multi",
	event = "VeryLazy", -- Load after core configs to avoid mapping conflicts
	init = function()
		-- Disable default mappings to prevent conflicts
		vim.g.VM_default_mappings = 0

		-- Custom mappings for vim-visual-multi to avoid conflicts with search navigation
		vim.g.VM_maps = {
			["Find Under"] = "<C-n>", -- Use Ctrl+n instead of just n
			["Find Subword Under"] = "<C-n>",
			["Add Cursor Down"] = "<C-Down>",
			["Add Cursor Up"] = "<C-Up>",
			["Select All"] = "<Leader>A",
			["Start Regex Search"] = "<Leader>/",
			["Add Cursor At Pos"] = "<Leader>\\",
		}

		-- Ensure normal search navigation is preserved
		vim.g.VM_set_statusline = 0 -- Don't change statusline
	end,
}
