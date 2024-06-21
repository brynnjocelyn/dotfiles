-- Bufferline is a snazzy buffer line for Neovim.
-- see: https://github.com/akinsho/bufferline.nvim
-- docs: :h bufferline
return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
			diagnostics = "nvim_lsp",
		},
	},
}
