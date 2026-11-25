-- zsh: command-line highlighting, and colors for zsh-syntax-highlighting
local shared = require('extras.shared')
local palette = shared.palette

-- The parts of cutiepro.zsh that do not come from the palette
local terminal_setup = [==[
# Approximate colors only when 24-bit is unavailable. Loading nearcolor
# unconditionally snaps every hex color to the 256-color cube, which looks
# brighter/off compared to Neovim.
[[ $COLORTERM == (truecolor|24bit) ]] || zmodload zsh/nearcolor 2>/dev/null

# macOS ls colors. BSD ls only supports the 16 ANSI colors, which the CutiePro
# Terminal profile maps to the palette: magenta dirs, blue executables,
# cyan links, sand pipes and devices. Regular files keep the default
# text color. Pairs are foreground+background (x = default); uppercase is bold.
# Letters: a black, b strawberry, c sour_apple, d sand, e blue, f magenta, g cyan.
export CLICOLOR=1
export LSCOLORS=FxgxcxdxexdxdxbxbxFxFx
]==]

-- The tokenizer that colors the command line, which reads the _cutiepro table
local highlighter = [==[
_cutiepro_highlight() {
	region_highlight=()
	local buf=$BUFFER n=${#BUFFER} i=1 j c w style
	local -i cmd=1
	local -a keywords=(if then else elif fi case in esac for do done select until while
		function declare typeset readonly local unset export '[[' ']]' '{' '}' '!')
	local -a continues=(if then else elif do while until '!' '{')

	while (( i <= n )); do
		c=${buf[i]}
		case $c in
		[[:space:]]) (( i++ )) ;;
		'#')
			if [[ -o interactive_comments ]]; then
				region_highlight+=("$((i-1)) $n ${_cutiepro[comment]}")
				break
			fi
			;&
		*)
			if [[ $c == "'" || $c == '"' ]]; then
				j=$(( i + 1 ))
				while (( j <= n )) && [[ ${buf[j]} != $c ]]; do
					[[ $c == '"' && ${buf[j]} == '\' ]] && (( j++ ))
					(( j++ ))
				done
				(( j > n )) && j=$n
				region_highlight+=("$((i-1)) $j ${_cutiepro[string]}")
				cmd=0; i=$(( j + 1 ))
			elif [[ $c == [\|\&\;\<\>\(\)] ]]; then
				j=$i
				while (( j < n )) && [[ ${buf[j+1]} == [\|\&\;\<\>\(\)] ]]; do (( j++ )); done
				region_highlight+=("$((i-1)) $j ${_cutiepro[operator]}")
				[[ ${buf[i,j]} == *[\<\>]* ]] || cmd=1
				i=$(( j + 1 ))
			else
				j=$i
				while (( j <= n )) && [[ ${buf[j]} != [[:space:]\|\&\;\<\>\(\)\'\"] ]]; do
					[[ ${buf[j]} == '\' ]] && (( j++ ))
					(( j++ ))
				done
				(( j > n )) && j=$(( n + 1 ))
				w=${buf[i,j-1]}
				if (( cmd )) && (( ${keywords[(Ie)$w]} )); then
					style=keyword
					(( ${continues[(Ie)$w]} )) || cmd=0
				elif (( cmd )) && [[ $w == [A-Za-z_]*=* ]]; then
					style=argument # VAR=value, command position continues
				elif (( cmd )); then
					if (( $+builtins[$w] )); then style=builtin
					elif (( $+commands[$w] + $+functions[$w] + $+aliases[$w] )) \
						|| [[ $w == */* && -x ${~w} ]]; then style=command
					else style=error
					fi
					cmd=0
				elif [[ $w == <-> ]]; then
					style=number
				else
					style=argument
				fi
				region_highlight+=("$((i-1)) $((j-1)) ${_cutiepro[$style]}")
				i=$j
			fi
			;;
		esac
	done
}

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-pre-redraw _cutiepro_highlight
]==]

-- Colors for the tokenizer in cutiepro.zsh, with the Treesitter capture that
-- each one follows
local highlight_colors = {
	{ 'command', palette.bright_magenta, '@function.call' },
	{ 'builtin', palette.bright_magenta, '@function.builtin', italic = true },
	{ 'keyword', palette.strawberry, '@keyword' },
	{ 'error', palette.strawberry, 'Error (unknown command)' },
	{ 'string', palette.sour_apple, '@string' },
	{ 'argument', palette.accent, '@variable.parameter / @variable' },
	{ 'number', palette.bright_blue, '@number' },
	{ 'operator', palette.honeycomb, '@operator, @punctuation' },
	{ 'comment', palette.foreground_muted, '@comment' },
}

local function style_value(hex, italic)
	return ("'fg=%s%s'"):format(hex, italic and ',italic' or '')
end

local function build_highlight_table()
	local widest_style = 0
	for _, color in ipairs(highlight_colors) do
		local style = style_value(color[2], color.italic)
		widest_style = math.max(widest_style, #style)
	end

	local lines = { 'typeset -gA _cutiepro=(' }
	for _, color in ipairs(highlight_colors) do
		local style = style_value(color[2], color.italic)
		table.insert(
			lines,
			('\t%-9s %-' .. widest_style .. 's # %s'):format(
				color[1],
				style,
				color[3]
			)
		)
	end
	table.insert(lines, ')')
	return table.concat(lines, '\n')
end

local function build_command_line_highlighting()
	return table.concat({
		'# CutiePro command-line highlighting for zsh. No plugins required.',
		'# Paste this block into ~/.zshrc, then run: source ~/.zshrc',
		'# ' .. shared.generated_note,
		'# Colors follow the Treesitter bash captures in lua/cutiepro/syntax.lua',
		'',
		terminal_setup,
		build_highlight_table(),
		'',
		highlighter,
	}, '\n')
end

-- Highlight styles, grouped as they are written. A blank line separates each
-- section, and each entry is a color followed by the styles that use it.
local syntax_sections = {
	{
		{ 'foreground', 'default' },
		{ 'strawberry', 'unknown-token', 'reserved-word', 'bracket-error' },
		{ 'foreground_muted', 'comment' },
	},
	{
		{
			'bright_magenta',
			'precommand',
			'command',
			'alias',
			'suffix-alias',
			'global-alias',
			'function',
			'hashed-command',
			'arg0',
		},
		{ 'bright_magenta', 'builtin', italic = true },
	},
	{
		{
			'honeycomb',
			'commandseparator',
			'redirection',
			'globbing',
			'history-expansion',
			'path_pathseparator',
			'path_prefix_pathseparator',
			'back-quoted-argument',
			'back-quoted-argument-delimiter',
		},
	},
	{
		{
			'accent',
			'autodirectory',
			'path',
			'path_prefix',
			'single-hyphen-option',
			'double-hyphen-option',
			'assign',
			'named-fd',
		},
	},
	{
		{
			'sour_apple',
			'single-quoted-argument',
			'double-quoted-argument',
			'dollar-quoted-argument',
		},
	},
	{
		{
			'bright_blue',
			'rc-quote',
			'dollar-double-quoted-argument',
			'back-double-quoted-argument',
			'back-dollar-quoted-argument',
			'numeric-fd',
		},
	},
}

local function build_syntax_highlighting()
	local lines = {
		'# CutiePro colors for zsh-syntax-highlighting and zsh-autosuggestions',
		'# Use this INSTEAD of cutiepro.zsh when you load those plugins, since they',
		'# paint with ANSI color names that the terminal maps to its own palette',
		'# Source this file after the plugins in ~/.zshrc, then run: source ~/.zshrc',
		'# ' .. shared.generated_note,
		'',
		'# Approximate colors only when 24-bit is unavailable',
		'[[ $COLORTERM == (truecolor|24bit) ]] || zmodload zsh/nearcolor 2>/dev/null',
		'',
		("ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=%s'"):format(
			palette.foreground_muted
		),
		'',
		'typeset -gA ZSH_HIGHLIGHT_STYLES',
		'ZSH_HIGHLIGHT_STYLES+=(',
	}

	for section_index, section in ipairs(syntax_sections) do
		if section_index > 1 then
			table.insert(lines, '')
		end
		for _, entry in ipairs(section) do
			local hex = palette[entry[1]]
			for style_index = 2, #entry do
				table.insert(
					lines,
					('\t%-30s %s'):format(
						entry[style_index],
						style_value(hex, entry.italic)
					)
				)
			end
		end
	end

	table.insert(lines, ')')
	return shared.join_lines(lines)
end

return {
	['extras/zsh/cutiepro.zsh'] = build_command_line_highlighting(),
	['extras/zsh/cutiepro-zsh-syntax-highlighting.zsh'] = build_syntax_highlighting(),
}
