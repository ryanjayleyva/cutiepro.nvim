-- Highlight groups for plugin integrations.
-- Groups are set unconditionally and are harmless when the plugin is
-- not installed.
local M = {}

function M.get(p, cfg)
	local bg = cfg.transparent and 'NONE' or p.bg

	return {
		-- gitsigns
		{ 'GitSignsAdd', { fg = p.green } },
		{ 'GitSignsChange', { fg = p.accent } },
		{ 'GitSignsDelete', { fg = p.red } },

		-- Telescope
		{ 'TelescopeNormal', { fg = p.fg, bg = bg } },
		{ 'TelescopeBorder', { fg = p.border, bg = bg } },
		{ 'TelescopePromptNormal', { fg = p.fg, bg = bg } },
		-- The prompt border uses the prompt background color so it
		-- stays invisible.
		{ 'TelescopePromptBorder', { fg = bg, bg = bg } },
		{ 'TelescopePromptTitle', { fg = p.accent, bold = true } },
		{ 'TelescopeResultsTitle', { fg = p.fg_dim } },
		-- The counter links to NonText by default, which is nearly
		-- invisible on the editor background.
		{ 'TelescopePromptCounter', { fg = p.fg_dim } },
		{ 'TelescopePreviewTitle', { fg = p.green } },
		{
			'TelescopeSelection',
			{ fg = p.accent, bg = p.bg_highlight, bold = true },
		},
		{ 'TelescopeMatching', { fg = p.accent, bold = true } },
		{ 'TelescopeMultiSelection', { bg = p.bg_highlight } },

		-- nvim-cmp
		{ 'CmpItemMenu', { fg = p.fg_dim } },
		{ 'CmpItemKind', { fg = p.lilac } },
		{ 'CmpItemKindVariable', { fg = p.accent } },
		{ 'CmpItemKindFunction', { fg = p.lilac } },
		{ 'CmpItemKindMethod', { fg = p.lilac } },
		{ 'CmpItemKindKeyword', { fg = p.red } },
		{ 'CmpItemKindSnippet', { fg = p.green } },
		{ 'CmpItemKindText', { fg = p.fg_dim } },

		-- indent-blankline
		{ 'IblIndent', { fg = p.border } },
		{ 'IblScope', { fg = p.fg_dim } },
	}
end

return M
