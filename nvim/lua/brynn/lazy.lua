-- Description: Lazy loading configuration for brynn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- Path to lazy.nvim

-- Install lazy.nvim if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Add lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup({
	{ import = "brynn.plugins" }, -- Load plugins
	{ import = "brynn.plugins.lsp" }, -- Load LSP
}, {
	install = {
		colorscheme = { "gruvbox" }, -- Load colorscheme
	},
	checker = {
		enabled = true, -- Enable checker
		notify = false, -- Disable notification
	},
	change_detection = {
		notify = false, -- Disable notification on change
	},
})
