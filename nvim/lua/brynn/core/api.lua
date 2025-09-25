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

-- Auto-load project-specific .nvim.lua files
api.nvim_create_autocmd("VimEnter", {
	desc = "Load project-specific .nvim.lua configuration",
	group = api.nvim_create_augroup("bm-project-config", { clear = true }),
	callback = function()
		local project_config = vim.fn.getcwd() .. "/.nvim.lua"
		if vim.fn.filereadable(project_config) == 1 then
			vim.cmd("luafile " .. project_config)
		end
	end,
})

-- remove keymap for `n` in normal mode
