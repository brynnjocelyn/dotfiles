return {
	"augmentcode/augment.vim",

	config = function()
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>at", "<cmd>Augment chat-toggle<cr>", {
			noremap = true,
			desc = "Toggle Augment chat",
		})
		keymap.set("n", "<leader>aa", "<cmd>Augment chat<cr>", {
			noremap = true,
			desc = "Augment chat",
		})
		keymap.set("n", "<leader>ac", "<cmd>Augment chat<cr>", {
			noremap = true,
			desc = "Augment chat",
		})
		keymap.set("n", "<leader>an", "<cmd>Augment chat-new<cr>", {
			noremap = true,
			desc = "New Augment chat",
		})
	end,
}
