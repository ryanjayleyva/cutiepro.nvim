-- nvim-cmp highlight groups
local M = {}

function M.get(palette)
	return {
		{ 'CmpItemMenu', { fg = palette.foreground_muted } },
		{ 'CmpItemKind', { fg = palette.bright_magenta } },
		{ 'CmpItemKindVariable', { fg = palette.accent } },
		{ 'CmpItemKindFunction', { fg = palette.bright_magenta } },
		{ 'CmpItemKindMethod', { fg = palette.bright_magenta } },
		{ 'CmpItemKindKeyword', { fg = palette.strawberry } },
		{ 'CmpItemKindSnippet', { fg = palette.sour_apple } },
		{ 'CmpItemKindText', { fg = palette.foreground_muted } },
	}
end

return M
