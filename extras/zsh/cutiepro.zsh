# CutiePro command-line highlighting for zsh. No plugins required.
# Paste this block into ~/.zshrc, then run: source ~/.zshrc
# Colors mirror lua/cutiepro/palette.lua and the Treesitter bash captures in
# lua/cutiepro/syntax.lua. Keep them in sync by hand.

zmodload zsh/nearcolor 2>/dev/null # approximate colors if 24-bit is unavailable

# macOS ls colors. BSD ls only supports the 16 ANSI colors, which the CutiePro
# Terminal profile maps to the palette: pink (magenta) dirs, teal executables,
# cyan-green links, yellow pipes and devices. Regular files keep the default
# text color. Pairs are foreground+background (x = default); uppercase is bold.
# Letters: a black, b red, c green, d yellow, e blue (teal), f magenta, g cyan.
export CLICOLOR=1
export LSCOLORS=FxgxcxdxexdxdxbxbxFxFx

typeset -gA _cutiepro=(
	command   'fg=#caa2ca'        # @function.call
	builtin   'fg=#caa2ca,italic' # @function.builtin
	keyword   'fg=#f56e7f'        # @keyword
	error     'fg=#f56e7f'        # Error (unknown command)
	string    'fg=#bec975'        # @string
	argument  'fg=#e5a1a3'        # @variable.parameter / @variable
	number    'fg=#a5b6ce'        # @number
	operator  'fg=#e8d6a7'        # @operator, @punctuation
	comment   'fg=#88847f'        # @comment
)

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
