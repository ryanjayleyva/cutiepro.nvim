# cutiepro.nvim

A dark pastel colorscheme for Neovim, ported from CutiePro 🩷

Warm pinks, muted olive greens, lilac functions, and soft neutral backgrounds, bringing the CutiePro aesthetic to your Neovim setup.

> This is an independent, community-made port of CutiePro. It is not affiliated with or maintained by the CutiePro organization.

## Features

- Carefully ported CutiePro color palette
- Treesitter syntax highlighting
- LSP diagnostics and document-reference highlights
- Telescope integration
- nvim-cmp completion highlighting
- Gitsigns support
- Indent guides and editor UI highlights
- Lualine theme included
- Optional transparent background
- Safe to reapply when switching colorschemes or reloading configuration

## Requirements

- Neovim 0.10 or newer
- True-color terminal support (`termguicolors`)

## Installation

### lazy.nvim

Add the following to your plugin specifications:

```lua
{
  "ryanjayleyva/cutiepro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cutiepro").setup()
    vim.cmd.colorscheme("cutiepro")
  end,
}
```

### Other plugin managers

You can install the repository using your preferred plugin manager. Make sure the repository is on your Neovim runtime path before running:

```lua
vim.cmd.colorscheme("cutiepro")
```

## Configuration

CutiePro works out of the box without calling `setup()`.

```lua
require("cutiepro").setup({
  transparent = false,
})
```

| Option        | Type    | Default | Description                                                                     |
| ------------- | ------- | ------- | ------------------------------------------------------------------------------- |
| `transparent` | boolean | `false` | Clears the backgrounds of the editor, floating windows, and the gutter columns. |

Enable transparency with:

```lua
require("cutiepro").setup({
  transparent = true,
})
```

Then activate the colorscheme:

```lua
vim.cmd.colorscheme("cutiepro")
```

## Lualine

A Lualine theme is included. Set it in your Lualine configuration:

```lua
require("lualine").setup({
  options = {
    theme = "cutiepro",
  },
})
```

## Troubleshooting

### Colors look washed out or incorrect

CutiePro sets `termguicolors` automatically when it loads, so the option itself rarely needs attention. Washed-out or incorrect colors usually mean your terminal emulator is not delivering 24-bit color. Check the option first:

```vim
:echo &termguicolors
```

The result should be `1`. If it is `0`, add the following to your Neovim configuration:

```lua
vim.opt.termguicolors = true
```

Your terminal emulator and its active profile must also support 24-bit (true) color. Many emulators disable it in some profiles, or under SSH, even when the emulator advertises support.

### Some plugin elements don't match the theme

Plugin highlight groups can vary between plugin versions and configurations. If you notice missing or incorrect highlights, feel free to open an issue with a screenshot and the relevant plugin details.

## Development

Clone the repository and open Neovim with the included development configuration:

```sh
nvim -u test/minimal_init.lua lua/cutiepro/init.lua
```

After editing the theme files, reapply it inside Neovim:

```vim
:colorscheme cutiepro
```

Run the smoke tests:

```sh
nvim --headless -u test/minimal_init.lua +"luafile test/smoke.lua"
```

The test suite verifies palette values, attribute integrity, repeated and transparent application, switching colorschemes, the plugin highlight groups, and the Lualine theme. It runs headless with no plugins installed, so it confirms that the theme defines the right highlight groups rather than exercising each plugin itself.

## Project structure

```
colors/cutiepro.lua             # :colorscheme entrypoint
lua/cutiepro/init.lua           # setup and highlight application
lua/cutiepro/palette.lua        # color definitions
lua/cutiepro/highlights.lua     # editor UI, LSP, diagnostics, diff
lua/cutiepro/syntax.lua         # syntax, Treesitter, markup
lua/cutiepro/plugins.lua        # plugin integrations
lua/lualine/themes/cutiepro.lua # Lualine theme
test/                           # development configuration and tests
```

## Palette

| Role             | Hex       |
| ---------------- | --------- |
| Background       | `#181716` |
| Foreground       | `#d5d0c9` |
| Comment / muted  | `#88847f` |
| Selection        | `#383838` |
| Cursorline       | `#242628` |
| Border           | `#2e2a27` |
| Accent / pink    | `#e5a1a3` |
| Keyword / red    | `#f56e7f` |
| String / green   | `#bec975` |
| Type / coral     | `#f58669` |
| Function / lilac | `#caa2ca` |
| Operator / cream | `#e8d6a7` |
| Number / sky     | `#a5b6ce` |

## Credits

- [CutiePro](https://github.com/cutiepro/cutiepro), the original theme and design.
- [cutiepro-zed](https://codeberg.org/wuemeli/cutiepro-zed) by wuemeli, used as the reference for editor color values.
- [cutiepro/helix](https://github.com/cutiepro/helix), used as the reference for additional UI colors.

## License

See LICENSE for licensing information.

This project is an independent port. Please refer to the upstream projects for their respective licenses and attribution requirements.

### Third-party sources and licenses

- **[CutiePro](https://github.com/cutiepro/cutiepro)**, the original theme and design. It is MIT licensed, copyright (c) 2024 jezzy jumble. The upstream LICENSE is at https://github.com/cutiepro/cutiepro/blob/main/LICENSE.
- **[cutiepro-zed](https://codeberg.org/wuemeli/cutiepro-zed)** by wuemeli, the reference for editor color values. It is MIT licensed, copyright (c) 2026 Wuemeli. See the upstream LICENSE at https://codeberg.org/wuemeli/cutiepro-zed/src/branch/main/LICENSE. The specific JSON file used for verification (`themes/cutiepro.json` at commit 7db4e4ba) matches the colors used in this port.
