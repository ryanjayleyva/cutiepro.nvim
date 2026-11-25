-- Palette for cutiepro.nvim
-- There is no upstream Neovim theme, so each entry is taken from an
-- existing CutiePro port. Keep values aligned with those sources
-- - Foreground, selection, the panel background and the 16 terminal colors
--   come from the original theme (github.com/cutiepro/cutiepro)
-- - Editor UI colors come from the Zed theme (codeberg.org/wuemeli/cutiepro-zed)
-- - Remaining extras come from the Helix port (github.com/cutiepro/helix)
local M = {}

local black = '#000000'
local accent = '#e5a1a3' -- primary pink, used for the cursor and focus
local red = '#f56e7f'
local green = '#bec975'
local yellow = '#f58669'
local teal = '#42d9c5'
local magenta = '#d286b7'
local cyan = '#37cb8a'
local orange = '#f4b86a'
local lilac = '#caa2ca'
local sky = '#a5b6ce'
local cream = '#e8d6a7'
local mint = '#5dccc3'
local leaf = '#97ca95'
local pink = '#ef7dc0'
local peach = '#e4b99d'
local lemon = '#ffef43'

-- The bright terminal colors that have no other use in the theme
local bright_yellow = '#f3b061'
local bright_blue = '#80c5de'
local bright_magenta = '#c3a6cb'
local bright_cyan = '#9ed7a8'

M.background = '#181716'
M.background_panel = '#181818' -- statusline and sidebars
M.background_gutter = '#212121' -- line numbers
M.background_cursorline = '#242628'
M.background_selection = '#383838'
M.background_popup = '#1f1e1b' -- floating windows and menus

M.foreground = '#d5d0c9'
M.foreground_bright = '#d7c3ba'
M.foreground_muted = '#88847f' -- comments and inactive text
M.border = '#2e2a27'

M.accent = accent
M.red = red
M.green = green
M.yellow = yellow
M.teal = teal
M.magenta = magenta
M.cyan = cyan
M.orange = orange
M.lilac = lilac
M.sky = sky
M.cream = cream
M.mint = mint
M.leaf = leaf
M.pink = pink
M.peach = peach
M.lemon = lemon
M.bright_yellow = bright_yellow
M.bright_blue = bright_blue
M.bright_magenta = bright_magenta
M.bright_cyan = bright_cyan

-- Maps each hex above back to its name, for docs and generators
local named = {
	black = black,
	accent = accent,
	red = red,
	green = green,
	yellow = yellow,
	teal = teal,
	magenta = magenta,
	cyan = cyan,
	orange = orange,
	lilac = lilac,
	sky = sky,
	cream = cream,
	mint = mint,
	leaf = leaf,
	pink = pink,
	peach = peach,
	lemon = lemon,
	bright_yellow = bright_yellow,
	bright_blue = bright_blue,
	bright_magenta = bright_magenta,
	bright_cyan = bright_cyan,
	background = M.background,
	background_panel = M.background_panel,
	background_gutter = M.background_gutter,
	background_cursorline = M.background_cursorline,
	background_selection = M.background_selection,
	background_popup = M.background_popup,
	foreground = M.foreground,
	foreground_bright = M.foreground_bright,
	foreground_muted = M.foreground_muted,
	border = M.border,
}

M.color_names = {}
for name, hex in pairs(named) do
	M.color_names[hex] = name
end

-- The 16 terminal colors, in order
-- Lua lists start at 1, so entry n is terminal color n - 1
M.terminal_colors = {
	black,
	red,
	green,
	yellow,
	teal,
	magenta,
	cyan,
	M.foreground_muted,
	M.border,
	accent,
	cream,
	bright_yellow,
	bright_blue,
	bright_magenta,
	bright_cyan,
	M.foreground_bright,
}

return M
