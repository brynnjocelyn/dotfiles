-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- show keymaps
keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<CR>", { desc = "Show keymaps" }) -- show keymaps

-- lazy management
keymap.set("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "Update Lazy Plugins" }) -- update lazy plugins
keymap.set("n", "<leader>li", "<cmd>Lazy install<CR>", { desc = "Install Lazy Plugins" }) -- install lazy plugins

-- source files. Useful for reloading to update changes made to the Neovim config
keymap.set("n", "<leader>so", "<cmd>luafile ~/.config/nvim/init.lua<CR>", { desc = "Source init.lua" }) -- source init.lua NOT SURE HOW OR IF THIS WORKS
keymap.set("n", "<leader>rl", "<cmd>so<CR>", { desc = "Source/Reload the current file" }) -- source/reload the current file

-- change mode keymaps
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" }) -- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" }) -- use jj to exit insert mode

-- navigation remaps
keymap.set({ "n", "v" }, "H", "^", { desc = "Go to start of line" }) -- go to start of line
keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" }) -- go to end of line

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" }) -- clear search highlights

-- delete single character without copying into register
keymap.set("n", "x", '"_x') -- delete single character without copying into register

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- terminal management
keymap.set("n", "<leader>tt", "<cmd>split term://zsh<CR>", { desc = "Open terminal in split window" }) -- open terminal in split window
keymap.set("n", "<leader>tv", "<cmd>vsplit term://zsh<CR>", { desc = "Open terminal in vertical split window" }) -- open terminal in vertical split window
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" }) -- exit terminal insert mode

-- buffer management
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close current buffer" }) -- close current buffer
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Go to next buffer" }) -- go to next buffer
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Go to previous buffer" }) -- go to previous buffer
keymap.set("n", "<leader>bl", "<cmd>ls<CR>", { desc = "List buffers" }) -- list buffers

-- file management
--keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" }) -- find files
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" }) -- live grep
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" }) -- find buffers
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help tags" }) -- find help tags
keymap.set("n", "<leader>fs", "<cmd>Telescope file_browser<CR>", { desc = "File browser" }) -- file browser
--keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" }) -- recent files
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Grep string" }) -- grep string

-- git management
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" }) -- git status
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" }) -- git commits
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" }) -- git branches
-- keymap.set("n", "<leader>df", "<cmd>Telescope git_diff<CR>", { desc = "Git diff" }) -- git diff (not working)
keymap.set("n", "<leader>gl", "<cmd>Telescope git_bcommits<CR>", { desc = "Git bcommits" }) -- git bcommits
keymap.set("n", "<leader>gp", "<cmd>Telescope git_patches<CR>", { desc = "Git patches" }) -- git patches

-- lsp management
keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" }) -- restart LSP
keymap.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", { desc = "Code actions" }) -- code actions
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Telescope lsp_range_code_actions<CR>", { desc = "Code actions (visual)" }) -- code actions (visual)
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" }) -- goto/show definition, references
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" }) -- go to declaration
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" }) -- show lsp definitions
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" }) -- show lsp implementations
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" }) -- show lsp type definitions
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Smart rename" }) -- smart rename
keymap.set("n", "<leader>D", "<cmd>Telescope lsp_workspace_diagnostics<CR>", { desc = "Show buffer diagnostics" }) -- show  diagnostics for file
keymap.set(
	"n",
	"<leader>d",
	"<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<CR>",
	{ desc = "Show line diagnostics" }
) -- show diagnostics for line
keymap.set(
	"n",
	"[d",
	"<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = 'single'}})<CR>",
	{ desc = "Go to previous diagnostic" }
) -- jump to previous diagnostic in buffer
keymap.set(
	"n",
	"]d",
	"<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = 'single'}})<CR>",
	{ desc = "Go to next diagnostic" }
) -- jump to next diagnostic in buffer
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

-- nvim-tree
keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" }) -- toggle nvim-tree
keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh nvim-tree" }) -- refresh nvim-tree
keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in nvim-tree" }) -- find file in nvim-tree

-- undotree
keymap.set("n", "<leader>uu", "<cmd>UndotreeToggle<CR>", { desc = "Toggle undotree" }) -- toggle undotree

-- prettier
keymap.set("n", "<leader>pp", "<cmd>Prettier<CR>", { desc = "Prettier" }) -- prettier

-- markdown preview
keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown preview" }) -- markdown preview

-- tailwindcss sorter
keymap.set("n", "<leader>ts", "<cmd>TailwindSort<CR>", { desc = "Sort tailwindcss classes" }) -- sort tailwindcss classes

-- obsidian note taking
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian note" }) -- new obsidian note
keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open Obsidian note" }) -- open obsidian note
keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian notes" }) -- search obsidian notes
keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" }) -- insert obsidian template
