# CutiePro colors for zsh-syntax-highlighting and zsh-autosuggestions.
# Use this INSTEAD of cutiepro.zsh when you load those plugins: they paint
# with ANSI color names (green, red, ...), which the terminal maps to its own
# palette, so the result differs from Neovim. Hex colors fix that.
# Source this file after the plugins in ~/.zshrc. Colors mirror
# lua/cutiepro/palette.lua and the bash captures in lua/cutiepro/syntax.lua.

# Exact hex colors, never the 256-color approximation.
[[ $COLORTERM == (truecolor|24bit) ]] || zmodload zsh/nearcolor 2>/dev/null

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#88847f' # @comment

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES+=(
	default                      'fg=#d5d0c9'
	unknown-token                'fg=#f56e7f'        # Error
	reserved-word                'fg=#f56e7f'        # @keyword
	precommand                   'fg=#caa2ca'
	commandseparator             'fg=#e8d6a7'        # @operator
	redirection                  'fg=#e8d6a7'
	globbing                     'fg=#e8d6a7'
	history-expansion            'fg=#e8d6a7'
	command                      'fg=#caa2ca'        # @function.call
	alias                        'fg=#caa2ca'
	suffix-alias                 'fg=#caa2ca'
	global-alias                 'fg=#caa2ca'
	function                     'fg=#caa2ca'
	builtin                      'fg=#caa2ca,italic' # @function.builtin
	hashed-command               'fg=#caa2ca'
	autodirectory                'fg=#e5a1a3'
	path                         'fg=#e5a1a3'
	path_pathseparator           'fg=#e8d6a7'
	path_prefix                  'fg=#e5a1a3'
	path_prefix_pathseparator    'fg=#e8d6a7'
	single-hyphen-option         'fg=#e5a1a3'        # @variable.parameter
	double-hyphen-option         'fg=#e5a1a3'
	back-quoted-argument         'fg=#e8d6a7'
	back-quoted-argument-delimiter 'fg=#e8d6a7'
	single-quoted-argument       'fg=#bec975'        # @string
	double-quoted-argument       'fg=#bec975'
	dollar-quoted-argument       'fg=#bec975'
	rc-quote                     'fg=#a5b6ce'        # @string.escape
	dollar-double-quoted-argument 'fg=#a5b6ce'
	back-double-quoted-argument  'fg=#a5b6ce'
	back-dollar-quoted-argument  'fg=#a5b6ce'
	assign                       'fg=#e5a1a3'
	named-fd                     'fg=#e5a1a3'
	numeric-fd                   'fg=#a5b6ce'        # @number
	arg0                         'fg=#caa2ca'
	comment                      'fg=#88847f'        # @comment
	bracket-error                'fg=#f56e7f'
)
