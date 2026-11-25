-- kulala.nvim highlight groups
local M = {}

function M.get(palette)
	-- HTTP method colors in the OpenAPI panel, replacing the fixed Swagger colors
	return {
		{ 'KulalaOpenAPIMethodGet', { fg = palette.bright_blue, bold = true } },
		{ 'KulalaOpenAPIMethodPost', { fg = palette.green, bold = true } },
		{ 'KulalaOpenAPIMethodPut', { fg = palette.orange, bold = true } },
		{ 'KulalaOpenAPIMethodDelete', { fg = palette.red, bold = true } },
		{ 'KulalaOpenAPIMethodPatch', { fg = palette.teal, bold = true } },
		{ 'KulalaOpenAPIMethodHead', { fg = palette.magenta, bold = true } },
		{ 'KulalaOpenAPIMethodOptions', { fg = palette.lilac, bold = true } },
	}
end

return M
