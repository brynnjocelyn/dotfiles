return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = "VimEnter", -- needed for folds to load in time and comments closed
	keys = {
    -- stylua: ignore start
    { "zm", function() require("ufo").closeAllFolds() end, desc = " 󱃄 Close All Folds" },
    { "zk", function() require("ufo").goPreviousClosedFold() end, desc = " 󱃄 Goto Prev Fold" },
    { "zj", function() require("ufo").goNextClosedFold() end, desc = " 󱃄 Goto Next Fold" },
    { "zr", function() require("ufo").openFoldsExceptKinds { "comment", "imports" } end, desc = " 󱃄 Open All Regular Folds" },
    { "zR", function() require("ufo").openFoldsExceptKinds {} end, desc = " 󱃄 Open All Folds" },
    { "z1", function() require("ufo").closeFoldsWith(1) end, desc = " 󱃄 Close L1 Folds" },
    { "z2", function() require("ufo").closeFoldsWith(2) end, desc = " 󱃄 Close L2 Folds" },
    { "z3", function() require("ufo").closeFoldsWith(3) end, desc = " 󱃄 Close L3 Folds" },
    { "z4", function() require("ufo").closeFoldsWith(4) end, desc = " 󱃄 Close L4 Folds" },
		-- stylua: ignore end
	},
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
	opts = {
		provider_selector = function(_, filetype, _)
			-- INFO some filetypes only allow indent, some only LSP, some only treesitter
			-- However, ufo only accepts two kinds as priority, therfor making this function necessary :/

			local lspWithoutFolding = { "markdown", "sh", "css", "html", "python" }

			if vim.tbl_contains(lspWithoutFolding, filetype) then
				return { "treesitter", "indent" }
			end

			return { "lsp", "indent" }
		end,
	},
}
