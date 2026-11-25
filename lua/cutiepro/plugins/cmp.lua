-- nvim-cmp highlight groups
local M = {}

function M.get(palette)
	return {
		{ 'CmpItemMenu', { fg = palette.foreground_muted } },
		{ 'CmpItemKind', { fg = palette.lilac } },
		{ 'CmpItemKindVariable', { fg = palette.accent } },
		{ 'CmpItemKindFunction', { fg = palette.lilac } },
		{ 'CmpItemKindMethod', { fg = palette.lilac } },
		{ 'CmpItemKindKeyword', { fg = palette.red } },
		{ 'CmpItemKindSnippet', { fg = palette.green } },
		{ 'CmpItemKindText', { fg = palette.foreground_muted } },
	}
end

return M
