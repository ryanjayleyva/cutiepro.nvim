-- Plugin highlight groups, one module per plugin in lua/cutiepro/plugins/
-- Each module receives (palette, options) and may declare only what it uses
-- Groups are set unconditionally and are harmless when the plugin is not
-- installed
local M = {}

local plugin_modules = { 'gitsigns' }

-- Telescope, nvim-cmp and indent-blankline, until they get their own modules
local function remaining_groups(palette, options)
	local background = options.transparent and 'NONE' or palette.background

	return {
		-- Telescope
		{ 'TelescopeNormal', { fg = palette.foreground, bg = background } },
		{ 'TelescopeBorder', { fg = palette.border, bg = background } },
		{ 'TelescopePromptNormal', { fg = palette.foreground, bg = background } },
		-- The prompt border uses the prompt background color so it
		-- stays invisible
		{ 'TelescopePromptBorder', { fg = background, bg = background } },
		{ 'TelescopePromptTitle', { fg = palette.accent, bold = true } },
		{ 'TelescopeResultsTitle', { fg = palette.foreground_muted } },
		-- The counter links to NonText by default, which is nearly
		-- invisible on the editor background
		{ 'TelescopePromptCounter', { fg = palette.foreground_muted } },
		{ 'TelescopePreviewTitle', { fg = palette.green } },
		{
			'TelescopeSelection',
			{ fg = palette.accent, bg = palette.background_selection, bold = true },
		},
		{ 'TelescopeMatching', { fg = palette.accent, bold = true } },
		{ 'TelescopeMultiSelection', { bg = palette.background_selection } },

		-- nvim-cmp
		{ 'CmpItemMenu', { fg = palette.foreground_muted } },
		{ 'CmpItemKind', { fg = palette.lilac } },
		{ 'CmpItemKindVariable', { fg = palette.accent } },
		{ 'CmpItemKindFunction', { fg = palette.lilac } },
		{ 'CmpItemKindMethod', { fg = palette.lilac } },
		{ 'CmpItemKindKeyword', { fg = palette.red } },
		{ 'CmpItemKindSnippet', { fg = palette.green } },
		{ 'CmpItemKindText', { fg = palette.foreground_muted } },

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
	vim.list_extend(groups, remaining_groups(palette, options))
	return groups
end

return M
