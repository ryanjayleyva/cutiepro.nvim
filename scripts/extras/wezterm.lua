-- WezTerm: a Lua module for config.colors
local shared = require('extras.shared')
local palette = shared.palette
local theme = shared.theme

-- Entries 1-8 are the normal colors, 9-16 the bright ones
local ansi_colors = { unpack(shared.terminal_colors, 1, 8) }
local bright_colors = { unpack(shared.terminal_colors, 9, 16) }

local tab_bar_background = palette.background

-- Tab bar states, in the order they are written
local tab_styles = {
	{
		name = 'active_tab',
		background = palette.accent,
		foreground = palette.background,
	},
	{
		name = 'inactive_tab',
		background = palette.background,
		foreground = palette.foreground_muted,
	},
	{
		name = 'inactive_tab_hover',
		background = palette.border,
		foreground = palette.foreground,
	},
	{
		name = 'new_tab',
		background = palette.background,
		foreground = palette.foreground_muted,
	},
	{
		name = 'new_tab_hover',
		background = palette.border,
		foreground = palette.foreground,
	},
}

local function build_lua_module()
	local lines = {
		'-- WezTerm colors for cutiepro.nvim',
		'-- ' .. shared.generated_note,
		'-- Copy this file next to wezterm.lua, then add to your config:',
		"--   config.colors = require('cutiepro')",
		'local M = {}',
		'',
		("M.foreground = '%s'"):format(theme.foreground),
		("M.background = '%s'"):format(theme.background),
		("M.cursor_bg = '%s'"):format(theme.cursor),
		("M.cursor_fg = '%s'"):format(theme.background),
		("M.cursor_border = '%s'"):format(theme.cursor),
		-- Lilac stays distinct from the cursor while composing characters
		("M.compose_cursor = '%s'"):format(palette.bright_magenta),
		("M.selection_fg = '%s'"):format(theme.selection_foreground),
		("M.selection_bg = '%s'"):format(theme.selection_background),
		("M.scrollbar_thumb = '%s'"):format(theme.selection_background),
		("M.split = '%s'"):format(theme.split),
		'',
		'M.ansi = {',
	}
	vim.list_extend(lines, shared.quoted_hex_lines(ansi_colors, '\t', "'"))
	table.insert(lines, '}')
	table.insert(lines, 'M.brights = {')
	vim.list_extend(lines, shared.quoted_hex_lines(bright_colors, '\t', "'"))

	vim.list_extend(lines, {
		'}',
		'',
		'-- The tab bar follows the Neovim statusline, with an accent bar for the active tab',
		'M.tab_bar = {',
		("\tbackground = '%s',"):format(tab_bar_background),
	})
	for _, tab in ipairs(tab_styles) do
		table.insert(
			lines,
			("\t%s = { bg_color = '%s', fg_color = '%s' },"):format(
				tab.name,
				tab.background,
				tab.foreground
			)
		)
	end

	vim.list_extend(lines, { '}', '', 'return M' })
	return shared.join_lines(lines)
end

return {
	['extras/wezterm/cutiepro.lua'] = build_lua_module(),
}
