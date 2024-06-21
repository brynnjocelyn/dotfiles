return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, -- what to run when executing the plugin
	build = "cd app && npm install", -- build command
	init = function()
		vim.g.mkdp_filetypes = { "markdown" } -- set file types to markdown
	end,
	ft = { "markdown" }, -- for which file types to load the plugin
	keys = {
		{ "n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" } },
	},
	config = function()
		vim.g.mkdp_auto_start = 0 -- start on open
		vim.g.mkdp_auto_close = 1 -- close on exit
		vim.g.mkdp_refresh_slow = 0 -- refresh slowly
		vim.g.mkdp_preview_options = {
			mkit = {}, -- markdown-it options for rendering markdown
			katex = {}, -- KateX options for math
			uml = {}, -- markdown-it-plantuml settings
			disable_sync_scroll = 0, -- disable sync scroll
			sync_scroll_type = "middle", -- sync scroll type (top, middle, relative)
			hide_yaml_meta = 1, -- hide yaml metadata in markdown files
			sequence_diagrams = {}, -- sequence diagrams settings (mermaid)
			flowchart_diagrams = {}, -- flowchart settings (mermaid)
		}
	end,
}
