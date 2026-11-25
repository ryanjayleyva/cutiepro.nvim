-- vim-dadbod-ui highlight groups
local M = {}

function M.get(palette)
	local status_groups = {
		{ 'dbui_connection_ok', { fg = palette.sour_apple } },
		{ 'dbui_connection_error', { fg = palette.strawberry } },
	}

	-- The plugin sets these two with fixed colors each time its buffer opens,
	-- after the colorscheme has loaded, so they are applied again afterward
	local augroup =
		vim.api.nvim_create_augroup('CutieproDadbod', { clear = true })
	vim.api.nvim_create_autocmd('FileType', {
		group = augroup,
		pattern = 'dbui',
		callback = function()
			vim.schedule(function()
				for _, status_group in ipairs(status_groups) do
					vim.api.nvim_set_hl(0, status_group[1], status_group[2])
				end
			end)
		end,
	})

	return status_groups
end

return M
