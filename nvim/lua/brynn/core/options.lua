local opt = vim.opt --for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- sroll offset
opt.scrolloff = 10 -- minimum number of lines to keep above and below cursor

-- concealing characters
-- opt.conceallevel = 2 -- conceal text with concealable characters

-- appearance
opt.termguicolors = true -- turn on termguicolors for nightfly colorscheme to work (have to use iterm2 or any other true color terminal)
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- baskspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.iskeyword:append("-")

-- set fold column colors
opt.foldcolumn = "auto:3" -- set fold column to 3 characters wide

-- conceal level
opt.conceallevel = 2 -- conceal text with concealable characters
