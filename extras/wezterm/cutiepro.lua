-- WezTerm color scheme for cutiepro.nvim.
-- WezTerm loads this as an ordinary Lua module, so it needs no Neovim
-- runtime and requires no other module. Copy it next to wezterm.lua as
-- cutiepro.lua and apply it with:
--   config.colors = require('cutiepro')
-- The table can also be pasted into wezterm.lua directly, drop the
-- leading `return` and prefix it with `config.colors = `.
-- Values mirror lua/cutiepro/palette.lua and the upstream WezTerm scheme
-- (github.com/cutiepro/cutiepro, schemes/WezTerm). Keep them in sync by hand.
return {
	foreground = '#d5d0c9',
	background = '#181818',

	cursor_bg = '#e5a1a3',
	cursor_fg = '#181818',
	cursor_border = '#e5a1a3',
	compose_cursor = '#caa2ca', -- palette lilac, distinct from the cursor

	selection_fg = '#d7c3ba',
	selection_bg = '#383838',

	scrollbar_thumb = '#383838',
	split = '#2e2a27',

	ansi = {
		'#000000',
		'#f56e7f',
		'#bec975',
		'#f58669',
		'#42d9c5',
		'#d286b7',
		'#37cb8a',
		'#88847f',
	},
	brights = {
		'#2e2a27',
		'#e5a1a3',
		'#e8d6a7',
		'#f3b061',
		'#80c5de',
		'#c3a6cb',
		'#9ed7a8',
		'#d7c3ba',
	},

	-- Matches the lualine theme: pink for focus, muted neutrals elsewhere.
	tab_bar = {
		background = '#181818',
		active_tab = { bg_color = '#e5a1a3', fg_color = '#181716' }, -- fg is palette bg, matching lualine's focused section
		inactive_tab = { bg_color = '#181818', fg_color = '#88847f' },
		inactive_tab_hover = { bg_color = '#242628', fg_color = '#d5d0c9' },
		new_tab = { bg_color = '#181818', fg_color = '#88847f' },
		new_tab_hover = { bg_color = '#242628', fg_color = '#d5d0c9' },
	},
}
