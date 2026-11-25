-- kulala.nvim highlight groups
local M = {}

function M.get(palette)
	-- HTTP method colors in the OpenAPI panel, replacing the fixed Swagger colors
	return {
		{ 'KulalaOpenAPIMethodGet', { fg = palette.bright_blue, bold = true } },
		{ 'KulalaOpenAPIMethodPost', { fg = palette.sour_apple, bold = true } },
		{ 'KulalaOpenAPIMethodPut', { fg = palette.bright_yellow, bold = true } },
		{ 'KulalaOpenAPIMethodDelete', { fg = palette.strawberry, bold = true } },
		{ 'KulalaOpenAPIMethodPatch', { fg = palette.blue, bold = true } },
		{ 'KulalaOpenAPIMethodHead', { fg = palette.magenta, bold = true } },
		{
			'KulalaOpenAPIMethodOptions',
			{ fg = palette.bright_magenta, bold = true },
		},
	}
end

return M
