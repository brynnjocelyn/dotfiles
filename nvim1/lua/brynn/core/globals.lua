local global = vim.g -- for consiseness, we'll use this file to store all global variables

global.skip_ts_context_commentstring_module = true -- skip backwards compatibility routines and speed up loading for comment string module.

P = function(v)
	print(vim.inspect(v)) -- pretty print lua
	return v -- return value for debugging
end

-- TODO: Add a function to toggle between light and dark themes
RELOAD = function(...)
	return require("plenary.reload").reload(...) -- reloads lua modules
end

R = function(module)
	RELOAD(module) -- reloads lua modules
	return require(module)
end
