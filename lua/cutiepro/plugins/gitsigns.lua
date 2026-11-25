-- gitsigns.nvim highlight groups
local M = {}

function M.get(palette)
	return {
		{ 'GitSignsAdd', { fg = palette.sour_apple } },
		{ 'GitSignsChange', { fg = palette.accent } },
		{ 'GitSignsDelete', { fg = palette.strawberry } },
	}
end

return M
