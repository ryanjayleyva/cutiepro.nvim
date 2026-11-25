-- nvim-treesitter-context highlight groups
local M = {}

function M.get(palette)
	return {
		-- Opaque even in transparent mode, so scrolling code does not show through
		{
			'TreesitterContext',
			{ fg = palette.foreground, bg = palette.background },
		},
		{ 'TreesitterContextLineNumber', { fg = palette.foreground_bright } },
		-- The separator is drawn in the background color, which hides it
		{ 'TreesitterContextSeparator', { fg = palette.background } },
	}
end

return M
