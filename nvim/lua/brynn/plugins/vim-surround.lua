return {
	"tpope/vim-surround",
	config = function()
		vim.api.nvim_set_keymap("n", "ys", "<Plug>Surround", { desc = "Surround" })
		vim.api.nvim_set_keymap("n", "cs", "<Plug>Substitute", { desc = "Change Surround" })
		vim.api.nvim_set_keymap("n", "ds", "<Plug>DeleteSurround", { desc = "Delete Surround" })
	end,
}
