-- Palette for cutiepro.nvim.
-- There is no upstream Neovim theme, so each entry is taken from an
-- existing CutiePro port. Keep values aligned with those sources:
-- - Foreground, selection, the panel background, and the 16 ANSI
--   colors: original theme (github.com/cutiepro/cutiepro)
-- - Editor UI colors: Zed theme (codeberg.org/wuemeli/cutiepro-zed)
-- - Remaining extras: Helix port (github.com/cutiepro/helix)
local M = {}

-- Backgrounds
M.bg = '#181716' -- editor background
M.bg_alt = '#181818' -- panels, statusline
M.bg_gutter = '#212121' -- line number gutter
M.bg_cursorline = '#242628' -- cursorline / active line
M.bg_highlight = '#383838' -- selection
M.bg_popup = '#1f1e1b' -- floating windows, pum

-- Text
M.fg = '#d5d0c9'
M.fg_bright = '#d7c3ba'
M.fg_dim = '#88847f' -- comments, muted text
M.border = '#2e2a27'

-- Accents
M.accent = '#e5a1a3' -- primary pink (cursor, focus)
M.red = '#f56e7f'
M.green = '#bec975'
M.yellow = '#f58669'
M.teal = '#42d9c5'
M.magenta = '#d286b7'
M.cyan = '#37cb8a'
M.orange = '#f4b86a'
M.lilac = '#caa2ca'
M.sky = '#a5b6ce'
M.cream = '#e8d6a7'
M.mint = '#5dccc3'
M.leaf = '#97ca95'
M.pink = '#ef7dc0'

-- Extras (from the Helix port)
M.peach = '#e4b99d'
M.lemon = '#ffef43'

-- 16 ANSI terminal colors
-- Lua indexing is 1-based, so ansi[n] holds ANSI color n - 1.
M.ansi = {
	'#000000', -- 0 black
	'#f56e7f', -- 1 red
	'#bec975', -- 2 green
	'#f58669', -- 3 yellow
	'#42d9c5', -- 4 blue
	'#d286b7', -- 5 magenta
	'#37cb8a', -- 6 cyan
	'#88847f', -- 7 white
	'#2e2a27', -- 8 bright black
	'#e5a1a3', -- 9 bright red
	'#e8d6a7', -- 10 bright green
	'#f3b061', -- 11 bright yellow
	'#80c5de', -- 12 bright blue
	'#c3a6cb', -- 13 bright magenta
	'#9ed7a8', -- 14 bright cyan
	'#d7c3ba', -- 15 bright white
}

return M
