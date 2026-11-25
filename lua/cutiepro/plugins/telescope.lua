-- telescope.nvim highlight groups
local M = {}

function M.get(palette, options)
	-- Transparent mode uses the terminal background
	local background = options.transparent and 'NONE' or palette.background

	return {
		{ 'TelescopeNormal', { fg = palette.foreground, bg = background } },
		{ 'TelescopeBorder', { fg = palette.border, bg = background } },
		{ 'TelescopePromptNormal', { fg = palette.foreground, bg = background } },
		-- The prompt border uses the prompt background color so it stays
		-- invisible
		{ 'TelescopePromptBorder', { fg = background, bg = background } },
		{ 'TelescopePromptTitle', { fg = palette.accent, bold = true } },
		{ 'TelescopeResultsTitle', { fg = palette.foreground_muted } },
		-- NonText is too dark to read for the counter
		{ 'TelescopePromptCounter', { fg = palette.foreground_muted } },
		{ 'TelescopePreviewTitle', { fg = palette.green } },
		{
			'TelescopeSelection',
			{ fg = palette.accent, bg = palette.background_selection, bold = true },
		},
		{ 'TelescopeMatching', { fg = palette.accent, bold = true } },
		{ 'TelescopeMultiSelection', { bg = palette.background_selection } },
	}
end

return M
