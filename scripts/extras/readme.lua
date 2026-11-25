-- README: the palette tables, drawn with one SVG swatch per color
local shared = require('extras.shared')
local palette = shared.palette

local files = {}

local editor_colors = {
	'background',
	'background_panel',
	'background_gutter',
	'background_cursorline',
	'background_selection',
	'background_popup',
	'foreground',
	'foreground_bright',
	'foreground_muted',
	'border',
}

-- The colors that are not one of the 16 terminal colors, with where they show
local syntax_colors = {
	{ name = 'orange', usage = 'Special characters, attributes and warnings' },
	{ name = 'lilac', usage = 'Functions and preprocessor' },
	{ name = 'sky', usage = 'Numbers, characters and escapes' },
	{ name = 'mint', usage = 'Builtin types' },
	{ name = 'leaf', usage = 'Labels and macros' },
	{ name = 'pink', usage = 'Links and underlined text' },
	{ name = 'peach', usage = 'Markdown quotes' },
	{ name = 'lemon', usage = 'Matching brackets' },
}

-- Every color shown in the README needs a name in palette.lua
local function color_name(hex)
	local name = palette.color_names[hex]
	assert(name, 'palette.lua has no name for ' .. hex)
	return name
end

-- Queues the SVG for this color and returns the markdown image that shows it
local function swatch_image(name, hex)
	local path = 'assets/swatches/' .. hex:sub(2) .. '.svg'
	files[path] = shared.join_lines({
		'<svg xmlns="http://www.w3.org/2000/svg" width="40" height="16" viewBox="0 0 40 16">',
		('\t<rect x="0.5" y="0.5" width="39" height="15" rx="3" fill="%s" stroke="#808080" stroke-opacity="0.5"/>'):format(
			hex
		),
		'</svg>',
	})
	return ('![%s](%s)'):format(name, path)
end

-- A markdown table with every column padded to its widest cell, which is how
-- a markdown formatter lays it out. The first row is the header.
local function markdown_table(rows)
	local widths = {}
	for _, row in ipairs(rows) do
		for column, cell in ipairs(row) do
			widths[column] = math.max(widths[column] or 0, #cell)
		end
	end

	local function format_row(row)
		local cells = {}
		for column, cell in ipairs(row) do
			table.insert(cells, cell .. (' '):rep(widths[column] - #cell))
		end
		return '| ' .. table.concat(cells, ' | ') .. ' |'
	end

	local divider = {}
	for column, width in ipairs(widths) do
		divider[column] = ('-'):rep(width)
	end

	local lines = { format_row(rows[1]), format_row(divider) }
	for row_index = 2, #rows do
		table.insert(lines, format_row(rows[row_index]))
	end
	return table.concat(lines, '\n')
end

local function build_palette_tables()
	local base_rows = { { 'Index', 'Name', 'Color', 'Hex' } }
	for index, hex in ipairs(shared.terminal_colors) do
		local name = color_name(hex)
		table.insert(base_rows, {
			tostring(index - 1),
			name,
			swatch_image(name, hex),
			('`%s`'):format(hex),
		})
	end

	local editor_rows = { { 'Role', 'Color', 'Hex' } }
	for _, role in ipairs(editor_colors) do
		local hex = palette[role]
		table.insert(editor_rows, {
			role,
			swatch_image(role, hex),
			('`%s`'):format(hex),
		})
	end

	local syntax_rows = { { 'Name', 'Color', 'Hex', 'Used for' } }
	for _, syntax_color in ipairs(syntax_colors) do
		local hex = palette[syntax_color.name]
		assert(
			color_name(hex) == syntax_color.name,
			'palette.lua names ' .. hex .. ' ' .. color_name(hex)
		)
		table.insert(syntax_rows, {
			syntax_color.name,
			swatch_image(syntax_color.name, hex),
			('`%s`'):format(hex),
			syntax_color.usage,
		})
	end

	return table.concat({
		markdown_table(base_rows),
		'',
		'### Editor colors',
		'',
		markdown_table(editor_rows),
		'',
		'### Syntax colors',
		'',
		markdown_table(syntax_rows),
	}, '\n')
end

-- Swaps what sits between two marker comments and keeps the markers
local function replace_between_markers(text, start_marker, end_marker, body)
	local _, start_marker_end = text:find(start_marker, 1, true)
	local end_marker_start = text:find(end_marker, 1, true)
	assert(start_marker_end, 'README.md is missing ' .. start_marker)
	assert(end_marker_start, 'README.md is missing ' .. end_marker)

	return text:sub(1, start_marker_end)
		.. '\n\n'
		.. body
		.. '\n\n'
		.. text:sub(end_marker_start)
end

-- Building the tables fills `files` with the swatches, so it runs first
local palette_tables = build_palette_tables()
files['README.md'] = replace_between_markers(
	shared.read_file(shared.repo_root .. '/README.md'),
	'<!-- palette:start -->',
	'<!-- palette:end -->',
	palette_tables
)

return files
