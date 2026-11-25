-- Smoke test for cutiepro.nvim. No framework, plain asserts.
--
-- Usage (from the repo root):
--   nvim --headless -u test/minimal_init.lua +"luafile test/smoke.lua"
--
-- Exits 0 on success, 1 on any failed assertion.
-- The minimal init has already applied the colorscheme at startup.

local function eq(actual, expected, msg)
	if actual ~= expected then
		error(
			('%s: expected %s, got %s'):format(
				msg,
				tostring(expected),
				tostring(actual)
			)
		)
	end
end

local function hex(c)
	return c and string.format('#%06x', c) or 'NONE'
end

local function fg(name)
	return hex(vim.api.nvim_get_hl(0, { name = name, link = false }).fg)
end

local function bg(name)
	return hex(vim.api.nvim_get_hl(0, { name = name, link = false }).bg)
end

local ok, err = pcall(function()
	-- 1. Colorscheme is active
	eq(vim.g.colors_name, 'cutiepro', 'colors_name')

	-- 2. Highlight groups resolve palette values to the expected colors
	eq(bg('Normal'), '#181716', 'Normal bg')
	eq(fg('Normal'), '#d5d0c9', 'Normal fg')
	eq(fg('Comment'), '#88847f', 'Comment fg')
	eq(fg('String'), '#bec975', 'String fg')
	eq(fg('Function'), '#caa2ca', 'Function fg')
	eq(fg('@keyword'), '#f56e7f', '@keyword fg')
	eq(bg('Visual'), '#383838', 'Visual bg')
	eq(vim.g.terminal_color_0, '#000000', 'terminal_color_0')
	eq(vim.g.terminal_color_11, '#f3b061', 'terminal_color_11')

	-- 2b. ANSI-derived groups use the intended ANSI entries (bright yellow
	-- ANSI 11, bright blue ANSI 12), guarding against 1-based index mistakes
	eq(fg('DiagnosticWarn'), '#f3b061', 'DiagnosticWarn fg (ANSI 11)')
	eq(fg('DiagnosticInfo'), '#80c5de', 'DiagnosticInfo fg (ANSI 12)')

	-- 2c. Every group the theme defines keeps at least one attribute,
	-- which catches references to missing or misspelled palette keys.
	local palette = require('cutiepro.palette')
	for _, module_name in ipairs({ 'highlights', 'syntax', 'plugins' }) do
		local module = require('cutiepro.' .. module_name)
		for _, group in ipairs(module.get(palette, { transparent = false })) do
			eq(next(group[2]) ~= nil, true, group[1] .. ' has attributes')
		end
	end

	-- 2d. Every terminal color has a name, which the generators rely on
	eq(#palette.terminal_colors, 16, 'terminal color count')
	for index, color in ipairs(palette.terminal_colors) do
		eq(
			palette.color_names[color] ~= nil,
			true,
			('terminal color %d has a name'):format(index - 1)
		)
	end

	-- 3. Re-applying the colorscheme is idempotent
	local snap = vim.api.nvim_get_hl(0, {})
	vim.cmd.colorscheme('cutiepro')
	eq(
		vim.deep_equal(snap, vim.api.nvim_get_hl(0, {})),
		true,
		'idempotent re-apply'
	)

	-- 4. Integration groups are defined even without the plugins installed
	for _, g in ipairs({
		'TelescopeSelection',
		'TelescopePromptCounter',
		'GitSignsAdd',
		'CmpItemKind',
		'IblIndent',
		'TreesitterContext',
		'DapBreakpoint',
		'NeotestPassed',
		'MasonHeader',
		'KulalaOpenAPIMethodGet',
		'dbui_connection_ok',
	}) do
		eq(
			vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = g })),
			false,
			g .. ' defined'
		)
	end

	-- 5. Lualine theme loads independently of Lualine
	local lualine = require('lualine.themes.cutiepro')
	eq(lualine.normal.a.bg, '#e5a1a3', 'lualine normal.a.bg')
	eq(lualine.visual.a.bg, '#80c5de', 'lualine visual.a.bg (ANSI 12)')
	eq(lualine.command.a.bg, '#f3b061', 'lualine command.a.bg (ANSI 11)')

	-- 6. Switching away and back works
	vim.cmd.colorscheme('default')
	vim.cmd.colorscheme('cutiepro')
	eq(vim.g.colors_name, 'cutiepro', 'colors_name after switch back')

	-- 7. Transparent option applies and reverts
	require('cutiepro').setup({ transparent = true })
	eq(bg('Normal'), 'NONE', 'transparent Normal bg')
	eq(bg('NormalFloat'), 'NONE', 'transparent NormalFloat bg')
	-- The sticky context stays opaque so scrolling code does not show through
	eq(bg('TreesitterContext'), '#181716', 'transparent TreesitterContext bg')
	require('cutiepro').setup({ transparent = false })
	eq(bg('Normal'), '#181716', 'reverted Normal bg')
	eq(bg('NormalFloat'), '#1f1e1b', 'reverted NormalFloat bg')

	-- 8. vim-dadbod-ui sets its status colors when its buffer opens, so the
	-- theme applies them again afterward
	vim.api.nvim_set_hl(0, 'dbui_connection_ok', { fg = '#00ff00' })
	vim.bo.filetype = 'dbui'
	vim.wait(200, function()
		return fg('dbui_connection_ok') == '#bec975'
	end)
	eq(
		fg('dbui_connection_ok'),
		'#bec975',
		'dbui_connection_ok after dbui buffer'
	)
end)

if ok then
	print('smoke: OK')
	vim.cmd('qa!')
else
	print('smoke: FAILED — ' .. tostring(err))
	vim.cmd('cq 1')
end
