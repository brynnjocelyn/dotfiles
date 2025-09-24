return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
			},
		})

		-- Set session options
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		-- Set mapping for searching a session using the modern approach
		vim.keymap.set("n", "<Leader>ls", "<cmd>AutoSession search<CR>", {
			noremap = true,
			desc = "Search sessions"
		})
	end,
}
