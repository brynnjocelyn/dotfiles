-- Api keymaps are a way to define keymaps in Lua. They are more powerful than the keymap command, but also more verbose.

local api = vim.api -- for conciseness

-- Highlight when yanking (copying) text
api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = api.nvim_create_augroup("bm-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 }) -- highlight yanked text for 200ms
	end,
})

-- remove keymap for `n` in normal mode
