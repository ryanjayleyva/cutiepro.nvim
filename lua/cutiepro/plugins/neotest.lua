-- neotest highlight groups
local M = {}

function M.get(palette)
	return {
		-- Test status
		{ 'NeotestPassed', { fg = palette.green } },
		{ 'NeotestFailed', { fg = palette.red } },
		{ 'NeotestRunning', { fg = palette.bright_yellow } },
		{ 'NeotestSkipped', { fg = palette.bright_blue } },
		{ 'NeotestWatching', { fg = palette.bright_yellow } },
		{ 'NeotestTarget', { fg = palette.red } },

		-- Summary tree
		{ 'NeotestNamespace', { fg = palette.yellow } },
		{ 'NeotestFile', { fg = palette.bright_blue } },
		{ 'NeotestDir', { fg = palette.bright_blue } },
		{ 'NeotestAdapterName', { fg = palette.yellow, bold = true } },
		{ 'NeotestIndent', { fg = palette.border } },
		{ 'NeotestExpandMarker', { fg = palette.foreground_muted } },
		{ 'NeotestMarked', { fg = palette.bright_yellow, bold = true } },
		{ 'NeotestWinSelect', { fg = palette.bright_blue, bold = true } },
	}
end

return M
