-- Editor UI, LSP, diagnostics, and diff highlight groups.
-- Add new UI-facing groups here and reference palette keys from
-- cutiepro.palette instead of raw color values.
local M = {}

function M.get(p, cfg)
	-- Transparency replaces panel backgrounds with 'NONE' so the
	-- terminal background shows through.
	local bg = cfg.transparent and 'NONE' or p.bg
	local gutter_bg = cfg.transparent and 'NONE' or p.bg_gutter

	return {
		-- Core editor
		{ 'Normal', { fg = p.fg, bg = bg } },
		{ 'NormalNC', { fg = p.fg, bg = bg } },
		{
			'NormalFloat',
			{ fg = p.fg, bg = cfg.transparent and 'NONE' or p.bg_popup },
		},
		{
			'FloatBorder',
			{ fg = p.border, bg = cfg.transparent and 'NONE' or p.bg_popup },
		},
		{ 'FloatTitle', { fg = p.accent, bold = true } },
		{ 'EndOfBuffer', { fg = p.border } },
		{ 'NonText', { fg = p.border } },
		{ 'Whitespace', { fg = p.border } },
		{ 'SpecialKey', { fg = p.border } },
		{ 'Conceal', { fg = p.fg_dim } },
		{ 'Cursor', { fg = p.bg, bg = p.accent } },
		{ 'lCursor', { fg = p.bg, bg = p.accent } },
		{ 'CursorIM', { fg = p.bg, bg = p.accent } },
		{ 'TermCursor', { fg = p.bg, bg = p.accent } },
		{ 'CursorLine', { bg = p.bg_cursorline } },
		{ 'CursorColumn', { bg = p.bg_cursorline } },
		{ 'ColorColumn', { bg = p.bg_cursorline } },
		{ 'LineNr', { fg = p.fg_dim, bg = gutter_bg } },
		{ 'CursorLineNr', { fg = p.accent, bg = gutter_bg, bold = true } },
		{ 'SignColumn', { bg = gutter_bg } },
		{ 'FoldColumn', { fg = p.fg_dim, bg = gutter_bg } },
		{ 'Folded', { fg = p.fg_dim, bg = gutter_bg } },
		{ 'Visual', { bg = p.bg_highlight } },
		{ 'VisualNOS', { bg = p.bg_highlight } },
		{ 'Search', { fg = p.bg, bg = p.accent } },
		{ 'CurSearch', { fg = p.bg, bg = p.accent, bold = true } },
		{ 'IncSearch', { fg = p.bg, bg = p.ansi[13] } },
		-- MatchParen uses the Helix port's lemon cursor-match color.
		{ 'MatchParen', { fg = p.lemon, bg = p.bg_highlight, bold = true } },
		{ 'QuickFixLine', { bg = p.bg_highlight, bold = true } },

		-- Menus
		{ 'Pmenu', { fg = p.fg, bg = p.bg_popup } },
		{ 'PmenuSel', { fg = p.accent, bg = p.bg_highlight, bold = true } },
		{ 'PmenuSbar', { bg = p.bg_highlight } },
		{ 'PmenuThumb', { bg = p.accent } },
		{ 'WildMenu', { fg = p.accent, bg = p.bg_highlight, bold = true } },

		-- Windows and tabs
		{ 'WinSeparator', { fg = p.border } },
		{ 'StatusLine', { fg = p.fg, bg = p.border } },
		{ 'StatusLineNC', { fg = p.fg_dim, bg = p.bg_alt } },
		{ 'TabLine', { fg = p.fg_dim, bg = p.bg_alt } },
		{ 'TabLineFill', { bg = p.bg_alt } },
		{ 'TabLineSel', { fg = p.accent, bg = p.border, bold = true } },

		-- Messages
		{ 'Title', { fg = p.accent, bold = true } },
		{ 'Directory', { fg = p.ansi[13] } },
		{ 'Question', { fg = p.red } },
		{ 'ModeMsg', { fg = p.fg, bold = true } },
		{ 'MoreMsg', { fg = p.green } },
		{ 'MsgArea', { fg = p.fg } },
		{ 'ErrorMsg', { fg = p.red, bold = true } },
		{ 'WarningMsg', { fg = p.ansi[12] } },

		-- Diff
		{ 'DiffAdd', { fg = p.green } },
		{ 'DiffChange', { fg = p.accent } },
		{ 'DiffDelete', { fg = p.red } },
		{ 'DiffText', { fg = p.fg, bg = p.bg_highlight, bold = true } },

		-- Diagnostics
		-- Warning and info reuse ANSI 11 (bright yellow) and ANSI 12
		-- (bright blue), which match the Zed port's warning and info
		-- colors.
		{ 'DiagnosticError', { fg = p.red } },
		{ 'DiagnosticWarn', { fg = p.ansi[12] } },
		{ 'DiagnosticInfo', { fg = p.ansi[13] } },
		{ 'DiagnosticHint', { fg = p.fg_dim } },
		{ 'DiagnosticOk', { fg = p.green } },
		{ 'DiagnosticUnderlineError', { undercurl = true, sp = p.red } },
		{ 'DiagnosticUnderlineWarn', { undercurl = true, sp = p.ansi[12] } },
		{ 'DiagnosticUnderlineInfo', { undercurl = true, sp = p.ansi[13] } },
		{ 'DiagnosticUnderlineHint', { undercurl = true, sp = p.fg_dim } },
		{ 'DiagnosticVirtualTextError', { fg = p.red } },
		{ 'DiagnosticVirtualTextWarn', { fg = p.ansi[12] } },
		{ 'DiagnosticVirtualTextInfo', { fg = p.ansi[13] } },
		{ 'DiagnosticVirtualTextHint', { fg = p.fg_dim } },
		{ 'LspReferenceText', { bg = p.border } },
		{ 'LspReferenceRead', { bg = p.border } },
		{ 'LspReferenceWrite', { bg = p.bg_highlight } },
		{ 'LspSignatureActiveParameter', { fg = p.orange, bold = true } },
		{ 'LspInfoBorder', { fg = p.border, bg = p.bg_popup } },
	}
end

return M
