-- Lualine theme for cutiepro.nvim.
-- Lualine loads it by name with options = { theme = "cutiepro" }.
-- Each mode overrides only the "a" section. Lualine falls back to the
-- "normal" colors for the sections a mode does not define.
local p = require('cutiepro.palette')

return {
	normal = {
		a = { bg = p.accent, fg = p.bg, gui = 'bold' },
		b = { bg = p.border, fg = p.fg },
		c = { bg = p.bg_alt, fg = p.fg_dim },
	},
	insert = { a = { bg = p.green, fg = p.bg, gui = 'bold' } },
	visual = { a = { bg = p.ansi[13], fg = p.bg, gui = 'bold' } },
	replace = { a = { bg = p.red, fg = p.bg, gui = 'bold' } },
	command = { a = { bg = p.ansi[12], fg = p.bg, gui = 'bold' } },
	inactive = {
		a = { bg = p.bg_alt, fg = p.fg_dim },
		b = { bg = p.bg_alt, fg = p.fg_dim },
		c = { bg = p.bg_alt, fg = p.fg_dim },
	},
}
