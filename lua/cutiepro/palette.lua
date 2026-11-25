-- Palette for cutiepro.nvim
-- Every color comes from the original theme (github.com/cutiepro/cutiepro)
-- Do not add colors that are not in it, reuse one of the 16 terminal colors
-- - Background, foreground and selection are the theme's own
-- - The names follow the Helix port (github.com/cutiepro/helix) where its
--   hex matches, and the ANSI slot is noted where the name is not obvious
local M = {}

local black = '#000000'
local accent = '#e5a1a3'
local strawberry = '#f56e7f'
local sour_apple = '#bec975'
local sand = '#f58669'
local blue = '#42d9c5'
local magenta = '#d286b7'
local cyan = '#37cb8a'
local honeycomb = '#e8d6a7'

-- The remaining bright terminal colors
local bright_yellow = '#f3b061'
local bright_blue = '#80c5de'
local bright_magenta = '#c3a6cb'
local bright_cyan = '#9ed7a8'

M.background = '#181818'
M.background_selection = '#383838'

M.foreground = '#d5d0c9'
M.foreground_bright = '#d7c3ba'
M.foreground_muted = '#88847f'
M.border = '#2e2a27'

M.accent = accent
M.strawberry = strawberry
M.sour_apple = sour_apple
M.sand = sand
M.blue = blue
M.magenta = magenta
M.cyan = cyan
M.honeycomb = honeycomb
M.bright_yellow = bright_yellow
M.bright_blue = bright_blue
M.bright_magenta = bright_magenta
M.bright_cyan = bright_cyan

-- Maps each hex above back to its name, for docs and generators
local named = {
	black = black,
	accent = accent,
	strawberry = strawberry,
	sour_apple = sour_apple,
	sand = sand,
	blue = blue,
	magenta = magenta,
	cyan = cyan,
	honeycomb = honeycomb,
	bright_yellow = bright_yellow,
	bright_blue = bright_blue,
	bright_magenta = bright_magenta,
	bright_cyan = bright_cyan,
	background = M.background,
	background_selection = M.background_selection,
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
	strawberry,
	sour_apple,
	sand,
	blue,
	magenta,
	cyan,
	M.foreground_muted,
	M.border,
	accent,
	honeycomb,
	bright_yellow,
	bright_blue,
	bright_magenta,
	bright_cyan,
	M.foreground_bright,
}

return M
