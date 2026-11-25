-- Plugin highlight groups, one module per plugin in lua/cutiepro/plugins/
-- Each module receives (palette, options) and may declare only what it uses
-- Groups are set unconditionally and are harmless when the plugin is not
-- installed
local M = {}

local plugin_modules = { 'gitsigns', 'cmp', 'telescope' }

-- indent-blankline, until it gets its own module
local function remaining_groups(palette)
	return {
		-- indent-blankline
		{ 'IblIndent', { fg = palette.border } },
		{ 'IblScope', { fg = palette.foreground_muted } },
	}
end

function M.get(palette, options)
	local groups = {}
	for _, module_name in ipairs(plugin_modules) do
		local module = require('cutiepro.plugins.' .. module_name)
		vim.list_extend(groups, module.get(palette, options))
	end
	vim.list_extend(groups, remaining_groups(palette))
	return groups
end

return M
