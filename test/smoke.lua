-- Smoke test for cutiepro.nvim, with plain asserts and no framework
--
-- Usage (from the repo root):
--   nvim --headless -u test/minimal_init.lua +"luafile test/smoke.lua"
--
-- Exits 0 on success, 1 on any failed assertion
-- The minimal init has already applied the colorscheme at startup

local palette = require('cutiepro.palette')

-- Colors that are not in the palette, so a match proves the theme set them
local plugin_default_color = '#123456'
local plugin_stale_color = '#00ff00'

local function eq(actual, expected, message)
	if actual ~= expected then
		error(
			('%s: expected %s, got %s'):format(
				message,
				tostring(expected),
				tostring(actual)
			)
		)
	end
end

local function to_hex(color)
	return color and string.format('#%06x', color) or 'NONE'
end

local function fg(name)
	return to_hex(vim.api.nvim_get_hl(0, { name = name, link = false }).fg)
end

local function bg(name)
	return to_hex(vim.api.nvim_get_hl(0, { name = name, link = false }).bg)
end

local ok, err = pcall(function()
	-- 1. Colorscheme is active
	eq(vim.g.colors_name, 'cutiepro', 'colors_name')

	-- 2. Highlight groups resolve palette values to the expected colors
	eq(bg('Normal'), palette.background, 'Normal bg')
	eq(fg('Normal'), palette.foreground, 'Normal fg')
	eq(fg('Comment'), palette.foreground_muted, 'Comment fg')
	eq(fg('String'), palette.sour_apple, 'String fg')
	eq(fg('Function'), palette.bright_magenta, 'Function fg')
	eq(fg('@keyword'), palette.strawberry, '@keyword fg')
	eq(bg('Visual'), palette.background_selection, 'Visual bg')
	eq(vim.g.terminal_color_0, palette.terminal_colors[1], 'terminal_color_0')
	eq(vim.g.terminal_color_11, palette.bright_yellow, 'terminal_color_11')

	-- 2b. ANSI-derived groups use the intended ANSI entries (bright yellow
	-- ANSI 11, bright blue ANSI 12), guarding against 1-based index mistakes
	eq(fg('DiagnosticWarn'), palette.bright_yellow, 'DiagnosticWarn fg (ANSI 11)')
	eq(fg('DiagnosticInfo'), palette.bright_blue, 'DiagnosticInfo fg (ANSI 12)')

	-- 2c. Every group the theme defines keeps at least one attribute,
	-- which catches references to missing or misspelled palette keys
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
	local highlights_before = vim.api.nvim_get_hl(0, {})
	vim.cmd.colorscheme('cutiepro')
	eq(
		vim.deep_equal(highlights_before, vim.api.nvim_get_hl(0, {})),
		true,
		'idempotent re-apply'
	)

	-- 4. Integration groups are defined even without the plugins installed
	for _, group_name in ipairs({
		'TelescopeSelection',
		'TelescopePromptCounter',
		'GitSignsAdd',
		'CmpItemKind',
		'IblIndent',
		'TreesitterContext',
		'DapBreakpoint',
		'NeotestPassed',
		'NeotestTest',
		'NeotestFocused',
		'NeotestBorder',
		'MasonHeader',
		'KulalaOpenAPIMethodGet',
		'dbui_connection_ok',
	}) do
		eq(
			vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = group_name })),
			false,
			group_name .. ' defined'
		)
	end

	-- 5. Lualine theme loads independently of Lualine
	local lualine = require('lualine.themes.cutiepro')
	eq(lualine.normal.a.bg, palette.accent, 'lualine normal.a.bg')
	eq(lualine.visual.a.bg, palette.bright_blue, 'lualine visual.a.bg (ANSI 12)')
	eq(
		lualine.command.a.bg,
		palette.bright_yellow,
		'lualine command.a.bg (ANSI 11)'
	)

	-- 6. Switching away and back works
	vim.cmd.colorscheme('default')
	vim.cmd.colorscheme('cutiepro')
	eq(vim.g.colors_name, 'cutiepro', 'colors_name after switch back')

	-- 7. Transparent option applies and reverts
	require('cutiepro').setup({ transparent = true })
	eq(bg('Normal'), 'NONE', 'transparent Normal bg')
	eq(bg('NormalFloat'), 'NONE', 'transparent NormalFloat bg')
	-- The sticky context stays opaque so scrolling code does not show through
	eq(
		bg('TreesitterContext'),
		palette.background,
		'transparent TreesitterContext bg'
	)
	require('cutiepro').setup({ transparent = false })
	eq(bg('Normal'), palette.background, 'reverted Normal bg')
	eq(bg('NormalFloat'), palette.border, 'reverted NormalFloat bg')
	-- A plugin that defines default groups on ColorScheme, like neotest, gets
	-- them back after a reload
	vim.api.nvim_create_autocmd('ColorScheme', {
		callback = function()
			vim.cmd(
				'highlight default SmokePluginDefault guifg=' .. plugin_default_color
			)
		end,
	})
	require('cutiepro').setup({ transparent = false })
	eq(
		fg('SmokePluginDefault'),
		plugin_default_color,
		'plugin default after reload'
	)
	-- Reloading clears groups that plugins define as defaults
	eq(
		vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = 'NeotestFocused' })),
		false,
		'NeotestFocused after reload'
	)

	-- 8. vim-dadbod-ui sets its status colors when its buffer opens, so the
	-- theme applies them again afterward
	vim.api.nvim_set_hl(0, 'dbui_connection_ok', { fg = plugin_stale_color })
	vim.bo.filetype = 'dbui'
	vim.wait(200, function()
		return fg('dbui_connection_ok') == palette.sour_apple
	end)
	eq(
		fg('dbui_connection_ok'),
		palette.sour_apple,
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
