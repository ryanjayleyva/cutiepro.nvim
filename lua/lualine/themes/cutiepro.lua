-- Lualine theme for cutiepro.nvim
-- Lualine loads it by name with options = { theme = 'cutiepro' }
-- Each mode overrides only the "a" section, and lualine falls back to the
-- "normal" colors for the sections a mode does not define
local palette = require('cutiepro.palette')

return {
	normal = {
		a = { bg = palette.accent, fg = palette.background, gui = 'bold' },
		b = { bg = palette.border, fg = palette.foreground },
		c = { bg = palette.background, fg = palette.foreground_muted },
	},
	insert = {
		a = { bg = palette.sour_apple, fg = palette.background, gui = 'bold' },
	},
	visual = {
		a = { bg = palette.bright_blue, fg = palette.background, gui = 'bold' },
	},
	replace = {
		a = { bg = palette.strawberry, fg = palette.background, gui = 'bold' },
	},
	command = {
		a = { bg = palette.bright_yellow, fg = palette.background, gui = 'bold' },
	},
	inactive = {
		a = { bg = palette.background, fg = palette.foreground_muted },
		b = { bg = palette.background, fg = palette.foreground_muted },
		c = { bg = palette.background, fg = palette.foreground_muted },
	},
}
