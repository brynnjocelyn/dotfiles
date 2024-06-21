local M = {}

--[[ M.dependencies = {
	"stevearc/dressing.nvim",
} ]]
-- make sure that dressing is installed
if not pcall(require, "dressing") then
	return
end

-- Function to display keymaps using dressing
-- local dressing = require("dressing")
local keymaps = require("brynn.core.keymaps")

local function get_menu_items()
	local menu_items = {}
	for mode, mappings in pairs(keymaps) do
		for mapping, details in pairs(mappings) do
			local desc = details.desc or ""
			table.insert(menu_items, {
				value = string.format("%s %s %s", mode, mapping, desc),
				ordinal = string.format("%s %s", mode, mapping),
				search = string.format("%s %s %s", mode, mapping, desc),
			})
		end
	end
	return menu_items
end

--[[ function M.show_keymaps()
	local menu_items = get_menu_items()
	dressing.select(menu_items, {
		prompt = "Keymaps",
		format_item = function(item)
			return item.value
		end,
		filter_func = dressing.fzy_filter,
		kind = dressing.kind.codeAction,
	})
end
 ]]
return M
