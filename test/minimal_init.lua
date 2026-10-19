-- Minimal configuration for testing the theme from the working directory.
-- It loads no user config and no plugins, so you can live-edit
-- lua/cutiepro/*.lua and re-run :colorscheme cutiepro to see changes.
--
-- Usage:
--   nvim -u test/minimal_init.lua lua/cutiepro/init.lua
--
-- Use your real configuration for the full experience with Treesitter,
-- Telescope, and other plugins. See the README.
local root = vim.fn.fnamemodify(
	vim.fn.resolve(debug.getinfo(1, 'S').source:sub(2)),
	':p:h:h'
)
vim.opt.runtimepath:prepend(root)
vim.opt.termguicolors = true

vim.cmd.colorscheme('cutiepro')
