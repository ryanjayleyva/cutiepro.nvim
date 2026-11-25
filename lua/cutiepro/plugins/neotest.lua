-- neotest highlight groups
local M = {}

function M.get(palette)
	return {
		-- Test status
		{ 'NeotestPassed', { fg = palette.green } },
		{ 'NeotestFailed', { fg = palette.red } },
		{ 'NeotestRunning', { fg = palette.accent } },
		{ 'NeotestSkipped', { fg = palette.sky } },
		{ 'NeotestWatching', { fg = palette.accent } },
		{ 'NeotestTarget', { fg = palette.red } },

		-- Summary tree
		{ 'NeotestNamespace', { fg = palette.sky } },
		{ 'NeotestFile', { fg = palette.green } },
		{ 'NeotestDir', { fg = palette.green } },
		{ 'NeotestAdapterName', { fg = palette.accent, bold = true } },
		{ 'NeotestIndent', { fg = palette.border } },
		{ 'NeotestExpandMarker', { fg = palette.foreground_muted } },
		{ 'NeotestMarked', { fg = palette.accent, bold = true } },
		{ 'NeotestWinSelect', { fg = palette.accent, bold = true } },
	}
end

return M
