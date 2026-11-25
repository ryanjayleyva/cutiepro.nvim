-- mason.nvim highlight groups
local M = {}

function M.get(palette)
	return {
		-- Backdrop behind the window
		{ 'MasonBackdrop', { bg = palette.background } },

		-- Window headers
		{
			'MasonHeader',
			{ fg = palette.background, bg = palette.accent, bold = true },
		},
		{
			'MasonHeaderSecondary',
			{ fg = palette.background, bg = palette.bright_blue, bold = true },
		},

		-- Primary accent, also used by MasonLink
		{ 'MasonHighlight', { fg = palette.bright_blue } },
		{
			'MasonHighlightBlock',
			{ fg = palette.background, bg = palette.bright_blue },
		},
		{
			'MasonHighlightBlockBold',
			{ fg = palette.background, bg = palette.bright_blue, bold = true },
		},

		-- Secondary accent
		{ 'MasonHighlightSecondary', { fg = palette.bright_yellow } },
		{
			'MasonHighlightBlockSecondary',
			{ fg = palette.background, bg = palette.bright_yellow },
		},
		{
			'MasonHighlightBlockBoldSecondary',
			{ fg = palette.background, bg = palette.bright_yellow, bold = true },
		},

		-- Muted text, such as versions and descriptions
		{ 'MasonMuted', { fg = palette.foreground_muted } },
		{
			'MasonMutedBlock',
			{ fg = palette.background, bg = palette.foreground_muted },
		},
		{
			'MasonMutedBlockBold',
			{ fg = palette.background, bg = palette.foreground_muted, bold = true },
		},
	}
end

return M
