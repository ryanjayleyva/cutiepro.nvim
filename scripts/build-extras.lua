-- Generates the terminal extras and the README palette tables from
-- lua/cutiepro/palette.lua
--   nvim -l scripts/build-extras.lua           write the files
--   nvim -l scripts/build-extras.lua --check   exit 1 if any file is out of date
-- Needs Neovim 0.10 or newer for vim.spairs and vim.base64.
--
-- Each module in scripts/extras returns a table of { path = file content },
-- with paths relative to the repo root. To add a target, create a module there
-- and list it below.

local scripts_dir =
	vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')
package.path = scripts_dir .. '/?.lua;' .. package.path

local shared = require('extras.shared')

local targets = {
	'extras.wezterm',
	'extras.ghostty',
	'extras.rex',
	'extras.zsh',
	'extras.terminal',
	'extras.readme',
}

local generated_files = {}
for _, target in ipairs(targets) do
	for path, content in pairs(require(target)) do
		generated_files[path] = content
	end
end

local check_only = vim.tbl_contains(arg, '--check')
local out_of_date = {}

-- Directories whose .svg files are all generated, so any the targets no longer
-- produce are stale, such as a swatch for a color that left the palette
local generated_dirs = { 'assets/swatches' }
local stale_files = {}
for _, dir in ipairs(generated_dirs) do
	for name, kind in vim.fs.dir(shared.repo_root .. '/' .. dir) do
		local path = dir .. '/' .. name
		if
			kind == 'file'
			and name:match('%.svg$')
			and not generated_files[path]
		then
			table.insert(stale_files, path)
		end
	end
end
table.sort(stale_files)

for path, content in vim.spairs(generated_files) do
	local full_path = shared.repo_root .. '/' .. path
	if shared.read_file(full_path) ~= content then
		if check_only then
			table.insert(out_of_date, path)
		else
			shared.write_file(full_path, content)
			print('wrote ' .. path)
		end
	end
end

for _, path in ipairs(stale_files) do
	if check_only then
		table.insert(out_of_date, path .. ' (stale)')
	else
		os.remove(shared.repo_root .. '/' .. path)
		print('removed ' .. path)
	end
end

if #out_of_date > 0 then
	io.stderr:write(
		'out of date, run nvim -l scripts/build-extras.lua:\n  '
			.. table.concat(out_of_date, '\n  ')
			.. '\n'
	)
	os.exit(1)
end
