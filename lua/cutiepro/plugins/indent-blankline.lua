-- indent-blankline.nvim highlight groups
local M = {}

function M.get(palette)
	return {
		{ 'IblIndent', { fg = palette.border } },
		{ 'IblScope', { fg = palette.foreground_muted } },
	}
end

return M
