return {
	"nvim-telescope/telescope-media-files.nvim",
	dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	setup = function()
		require("telescope").setup({
			extensions = {
				media_files = {
					-- filetypes whitelist
					filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf" },
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
			},
		})
		require("telescope").load_extension("media_files")
	end,
}
