-- Ghostty: one theme file
local shared = require('extras.shared')
local theme = shared.theme

local function build_theme()
	local lines = {
		'# Ghostty colors for cutiepro.nvim',
		'# ' .. shared.generated_note,
		'# Copy this file to ~/.config/ghostty/themes/cutiepro, then add to your config:',
		'#   theme = cutiepro',
		'# Using Rex (https://www.superlogical.com/updates/public-testing-beginning)?',
		'# Import this file in Rex to use cutiepro.',
		'',
	}

	for index, hex in ipairs(shared.terminal_colors) do
		-- Ghostty counts palette entries from 0
		table.insert(lines, ('palette = %d=%s'):format(index - 1, hex))
	end

	vim.list_extend(lines, {
		'',
		('background = %s'):format(theme.background),
		('foreground = %s'):format(theme.foreground),
		('cursor-color = %s'):format(theme.cursor),
		('selection-background = %s'):format(theme.selection_background),
		('selection-foreground = %s'):format(theme.selection_foreground),
	})
	return shared.join_lines(lines)
end

return {
	['extras/ghostty/cutiepro'] = build_theme(),
}
