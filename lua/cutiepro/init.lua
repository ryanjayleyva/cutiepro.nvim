local M = {}

M.options = { transparent = false }

function M.setup(opts)
	M.options = vim.tbl_deep_extend('force', M.options, opts or {})
	-- Re-apply immediately so option changes take effect without
	-- another :colorscheme call.
	if vim.g.colors_name == 'cutiepro' then
		M.load()
	end
end

function M.load()
	-- Clear first so no stale highlights survive (:help colorscheme).
	vim.cmd('highlight clear')
	if vim.fn.exists('syntax_on') == 1 then
		vim.cmd('syntax reset')
	end
	-- The palette uses 24-bit colors, so enable termguicolors here.
	vim.o.termguicolors = true
	vim.g.colors_name = 'cutiepro'

	local p = require('cutiepro.palette')

	local groups = {}
	for _, mod in ipairs({ 'highlights', 'syntax', 'plugins' }) do
		vim.list_extend(groups, require('cutiepro.' .. mod).get(p, M.options))
	end
	for _, hl in ipairs(groups) do
		vim.api.nvim_set_hl(0, hl[1], hl[2])
	end

	-- Expose the ANSI palette to Neovim's built-in terminal.
	for i, color in ipairs(p.ansi) do
		vim.g['terminal_color_' .. (i - 1)] = color
	end
end

return M
