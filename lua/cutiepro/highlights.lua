-- Editor UI highlight groups (Normal, StatusLine, Pmenu, ...)
local M = {}

function M.get(palette, options)
	-- Transparent mode uses the terminal background
	local background = options.transparent and 'NONE' or palette.background
	local background_popup = options.transparent and 'NONE' or palette.border

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
		{ 'CursorLine', { bg = palette.border } },
		{ 'CursorColumn', { bg = palette.border } },
		{ 'ColorColumn', { bg = palette.border } },

		-- Gutter
		{ 'LineNr', { fg = palette.foreground_muted, bg = background } },
		{
			'CursorLineNr',
			{ fg = palette.accent, bg = background, bold = true },
		},
		{ 'SignColumn', { bg = background } },
		{
			'FoldColumn',
			{ fg = palette.foreground_muted, bg = background },
		},
		{ 'Folded', { fg = palette.foreground_muted, bg = background } },

		-- Selection and search
		{ 'Visual', { bg = palette.background_selection } },
		{ 'VisualNOS', { bg = palette.background_selection } },
		{ 'Search', { fg = palette.background, bg = palette.accent } },
		{
			'CurSearch',
			{ fg = palette.background, bg = palette.accent, bold = true },
		},
		{ 'IncSearch', { fg = palette.background, bg = palette.bright_blue } },
		-- Bright yellow stands out from the selection color
		{
			'MatchParen',
			{
				fg = palette.bright_yellow,
				bg = palette.background_selection,
				bold = true,
			},
		},
		{ 'QuickFixLine', { bg = palette.background_selection, bold = true } },

		-- Completion and wildmenu
		{ 'Pmenu', { fg = palette.foreground, bg = palette.border } },
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
			{ fg = palette.foreground_muted, bg = palette.background },
		},
		{
			'TabLine',
			{ fg = palette.foreground_muted, bg = palette.background },
		},
		{ 'TabLineFill', { bg = palette.background } },
		{
			'TabLineSel',
			{ fg = palette.accent, bg = palette.border, bold = true },
		},

		-- Messages
		{ 'Title', { fg = palette.accent, bold = true } },
		{ 'Directory', { fg = palette.bright_blue } },
		{ 'Question', { fg = palette.strawberry } },
		{ 'ModeMsg', { fg = palette.foreground, bold = true } },
		{ 'MoreMsg', { fg = palette.sour_apple } },
		{ 'ErrorMsg', { fg = palette.strawberry, bold = true } },
		{ 'WarningMsg', { fg = palette.bright_yellow } },

		-- Diff
		{ 'DiffAdd', { fg = palette.sour_apple } },
		{ 'DiffChange', { fg = palette.accent } },
		{ 'DiffDelete', { fg = palette.strawberry } },
		{
			'DiffText',
			{
				fg = palette.foreground,
				bg = palette.background_selection,
				bold = true,
			},
		},

		-- Diagnostics
		-- Warning and info use the bright yellow and bright blue terminal colors
		{ 'DiagnosticError', { fg = palette.strawberry } },
		{ 'DiagnosticWarn', { fg = palette.bright_yellow } },
		{ 'DiagnosticInfo', { fg = palette.bright_blue } },
		{ 'DiagnosticHint', { fg = palette.foreground_muted } },
		{ 'DiagnosticOk', { fg = palette.sour_apple } },
		{
			'DiagnosticUnderlineError',
			{ undercurl = true, sp = palette.strawberry },
		},
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
		{ 'DiagnosticVirtualTextError', { fg = palette.strawberry } },
		{ 'DiagnosticVirtualTextWarn', { fg = palette.bright_yellow } },
		{ 'DiagnosticVirtualTextInfo', { fg = palette.bright_blue } },
		{ 'DiagnosticVirtualTextHint', { fg = palette.foreground_muted } },

		-- LSP
		{ 'LspReferenceText', { bg = palette.border } },
		{ 'LspReferenceRead', { bg = palette.border } },
		{ 'LspReferenceWrite', { bg = palette.background_selection } },
		{
			'LspSignatureActiveParameter',
			{ fg = palette.bright_yellow, bold = true },
		},
		{
			'LspInfoBorder',
			{ fg = palette.border, bg = palette.border },
		},
	}
end

return M
