-- neotest highlight groups
local M = {}

function M.get(palette)
	return {
		-- Test status
		{ 'NeotestPassed', { fg = palette.sour_apple } },
		{ 'NeotestFailed', { fg = palette.strawberry } },
		{ 'NeotestRunning', { fg = palette.accent } },
		{ 'NeotestSkipped', { fg = palette.bright_blue } },
		{ 'NeotestWatching', { fg = palette.accent } },
		{ 'NeotestTarget', { fg = palette.strawberry } },

		-- Summary tree
		{ 'NeotestNamespace', { fg = palette.bright_blue } },
		{ 'NeotestFile', { fg = palette.sour_apple } },
		{ 'NeotestDir', { fg = palette.sour_apple } },
		{ 'NeotestAdapterName', { fg = palette.accent, bold = true } },
		{ 'NeotestIndent', { fg = palette.border } },
		{ 'NeotestExpandMarker', { fg = palette.foreground_muted } },
		{ 'NeotestMarked', { fg = palette.accent, bold = true } },
		{ 'NeotestWinSelect', { fg = palette.accent, bold = true } },

		-- Neotest defines these with its own defaults, which a theme reload
		-- clears, so they are set here
		{ 'NeotestTest', { fg = palette.foreground } },
		{ 'NeotestUnknown', { fg = palette.foreground } },
		{ 'NeotestFocused', { bold = true, underline = true } },
		{ 'NeotestBorder', { link = 'FloatBorder' } },
	}
end

return M
