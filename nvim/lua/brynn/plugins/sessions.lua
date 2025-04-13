return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			session_lens = {
				buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
			},
      suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
			-- Set mapping for searching a session.
			vim.keymap.set("n", "<Leader>ls", require("auto-session.session-lens").search_session, {
				noremap = true,
			}),
		})
    -- Set session options
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

	end,
}
