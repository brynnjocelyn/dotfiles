-- Api keymaps are a way to define keymaps in Lua. They are more powerful than the keymap command, but also more verbose. Here is the same keymaps defined using the api keymap:

local api = vim.api -- for conciseness

-- api.nvim_exec(
-- 	[[
--   autocmd BufWritePost *.ts,*.html,*.scss !ng lint
-- ]],
-- 	false -- don't echo command
-- ) -- run ng lint on save for ts, html, scss files
