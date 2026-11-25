-- gitsigns.nvim highlight groups
local M = {}

function M.get(palette)
	return {
		{ 'GitSignsAdd', { fg = palette.green } },
		{ 'GitSignsChange', { fg = palette.accent } },
		{ 'GitSignsDelete', { fg = palette.red } },
	}
end

return M
