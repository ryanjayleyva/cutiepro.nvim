-- Editor UI highlight groups (Normal, StatusLine, Pmenu, ...)
local M = {}

function M.get(palette, options)
	-- Transparent mode uses the terminal background
	local background = options.transparent and 'NONE' or palette.background
	local background_gutter = options.transparent and 'NONE'
		or palette.background_gutter
	local background_popup = options.transparent and 'NONE'
		or palette.background_popup

	return {
		-- Base
		{ 'Normal', { fg = palette.foreground, bg = background } },
		{ 'NormalNC', { fg = palette.foreground, bg = background } },
		{ 'NormalFloat', { fg = palette.foreground, bg = background_popup } },
		{ 'FloatBorder', { fg = palette.border, bg = background_popup } },
		{ 'FloatTitle', { fg = palette.accent, bold = true } },
		{ 'MsgArea', { fg = palette.foreground } },
		{ 'EndOfBuffer', { fg = palette.border } },

		-- Invisible characters
		{ 'NonText', { fg = palette.border } },
		{ 'Whitespace', { fg = palette.border } },
		{ 'SpecialKey', { fg = palette.border } },
		{ 'Conceal', { fg = palette.foreground_muted } },

		-- Cursor
		{ 'Cursor', { fg = palette.background, bg = palette.accent } },
		{ 'lCursor', { fg = palette.background, bg = palette.accent } },
		{ 'CursorIM', { fg = palette.background, bg = palette.accent } },
		{ 'TermCursor', { fg = palette.background, bg = palette.accent } },
		{ 'CursorLine', { bg = palette.background_cursorline } },
		{ 'CursorColumn', { bg = palette.background_cursorline } },
		{ 'ColorColumn', { bg = palette.background_cursorline } },

		-- Gutter
		{ 'LineNr', { fg = palette.foreground_muted, bg = background_gutter } },
		{
			'CursorLineNr',
			{ fg = palette.accent, bg = background_gutter, bold = true },
		},
		{ 'SignColumn', { bg = background_gutter } },
		{
			'FoldColumn',
			{ fg = palette.foreground_muted, bg = background_gutter },
		},
		{ 'Folded', { fg = palette.foreground_muted, bg = background_gutter } },

		-- Selection and search
		{ 'Visual', { bg = palette.background_selection } },
		{ 'VisualNOS', { bg = palette.background_selection } },
		{ 'Search', { fg = palette.background, bg = palette.accent } },
		{
			'CurSearch',
			{ fg = palette.background, bg = palette.accent, bold = true },
		},
		{ 'IncSearch', { fg = palette.background, bg = palette.bright_blue } },
		-- Lemon is the cursor match color from the Helix port
		{
			'MatchParen',
			{ fg = palette.lemon, bg = palette.background_selection, bold = true },
		},
		{ 'QuickFixLine', { bg = palette.background_selection, bold = true } },

		-- Completion and wildmenu
		{ 'Pmenu', { fg = palette.foreground, bg = palette.background_popup } },
		{
			'PmenuSel',
			{ fg = palette.accent, bg = palette.background_selection, bold = true },
		},
		{ 'PmenuSbar', { bg = palette.background_selection } },
		{ 'PmenuThumb', { bg = palette.accent } },
		{
			'WildMenu',
			{ fg = palette.accent, bg = palette.background_selection, bold = true },
		},

		-- Windows and tabs
		{ 'WinSeparator', { fg = palette.border } },
		{ 'StatusLine', { fg = palette.foreground, bg = palette.border } },
		{
			'StatusLineNC',
			{ fg = palette.foreground_muted, bg = palette.background_panel },
		},
		{
			'TabLine',
			{ fg = palette.foreground_muted, bg = palette.background_panel },
		},
		{ 'TabLineFill', { bg = palette.background_panel } },
		{
			'TabLineSel',
			{ fg = palette.accent, bg = palette.border, bold = true },
		},

		-- Messages
		{ 'Title', { fg = palette.accent, bold = true } },
		{ 'Directory', { fg = palette.bright_blue } },
		{ 'Question', { fg = palette.red } },
		{ 'ModeMsg', { fg = palette.foreground, bold = true } },
		{ 'MoreMsg', { fg = palette.green } },
		{ 'ErrorMsg', { fg = palette.red, bold = true } },
		{ 'WarningMsg', { fg = palette.bright_yellow } },

		-- Diff
		{ 'DiffAdd', { fg = palette.green } },
		{ 'DiffChange', { fg = palette.accent } },
		{ 'DiffDelete', { fg = palette.red } },
		{
			'DiffText',
			{
				fg = palette.foreground,
				bg = palette.background_selection,
				bold = true,
			},
		},

		-- Diagnostics
		-- Warning and info use the bright yellow and bright blue terminal
		-- colors, which match the Zed port
		{ 'DiagnosticError', { fg = palette.red } },
		{ 'DiagnosticWarn', { fg = palette.bright_yellow } },
		{ 'DiagnosticInfo', { fg = palette.bright_blue } },
		{ 'DiagnosticHint', { fg = palette.foreground_muted } },
		{ 'DiagnosticOk', { fg = palette.green } },
		{ 'DiagnosticUnderlineError', { undercurl = true, sp = palette.red } },
		{
			'DiagnosticUnderlineWarn',
			{ undercurl = true, sp = palette.bright_yellow },
		},
		{
			'DiagnosticUnderlineInfo',
			{ undercurl = true, sp = palette.bright_blue },
		},
		{
			'DiagnosticUnderlineHint',
			{ undercurl = true, sp = palette.foreground_muted },
		},
		{ 'DiagnosticVirtualTextError', { fg = palette.red } },
		{ 'DiagnosticVirtualTextWarn', { fg = palette.bright_yellow } },
		{ 'DiagnosticVirtualTextInfo', { fg = palette.bright_blue } },
		{ 'DiagnosticVirtualTextHint', { fg = palette.foreground_muted } },

		-- LSP
		{ 'LspReferenceText', { bg = palette.border } },
		{ 'LspReferenceRead', { bg = palette.border } },
		{ 'LspReferenceWrite', { bg = palette.background_selection } },
		{
			'LspSignatureActiveParameter',
			{ fg = palette.orange, bold = true },
		},
		{
			'LspInfoBorder',
			{ fg = palette.border, bg = palette.background_popup },
		},
	}
end

return M
