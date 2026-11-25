-- Plugin highlight groups, one module per plugin in lua/cutiepro/plugins/
-- Each module receives (palette, options) and may declare only what it uses
-- Groups are set unconditionally and are harmless when the plugin is not
-- installed
local M = {}

local plugin_modules = {
	'gitsigns',
	'cmp',
	'telescope',
	'indent-blankline',
	'treesitter-context',
	'dap',
	'neotest',
	'mason',
	'kulala',
}

function M.get(palette, options)
	local groups = {}
	for _, module_name in ipairs(plugin_modules) do
		local module = require('cutiepro.plugins.' .. module_name)
		vim.list_extend(groups, module.get(palette, options))
	end
	return groups
end

return M
