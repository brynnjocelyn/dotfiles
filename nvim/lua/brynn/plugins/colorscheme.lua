return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
			-- There are also colorschemes for the different styles.
			--[[ colorscheme tokyonight-night
          colorscheme tokyonight-storm
          colorscheme tokyonight-day
          colorscheme tokyonight-moon ]]
		end,
		opts = {},
	},
	{
		"bluz71/vim-nightfly-guicolors",
		-- "ellisonleao/gruvbox.nvim",
		priority = 1000, -- make sure to load this before all the other,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme nightfly]])
		end,
	},
}
