# awesome-nvim-config

Neovim configuration with a focus on simplicity, ease of use, and consistency.
Designed to resemble "vanilla" Vim/Neovim with support for LSP, autoformatting,
git integration, and various other improvements.

![Screenshot of config](preview.png)

## Features

- Performance is nearly identical to vanilla vim/nvim, opens in ~13 ms
- A choice of custom-made colorschemes, with the ability to easily add more
- LSP configurations for the most popular languages with `nvim-lspconfig`
- Code actions and performant, unintrusive autocomplete with `blink.cmp`
- Syntax highlighting and context with `nvim-treesitter` and
  `nvim-treesitter-context`
- Automatic format on save with `conform.nvim`
- GitHub copilot integration with agent capabilities with `copilot.lua` and
  `codecompanion.nvim`
- Vim-surround key mappings with `nvim-surround`
- Automatic pair completion with `nvim-autopairs` and `nvim-ts-autotag`
- Extensive git integration with `gitsigns.nvim`, `vim-fugitive`, and
  `conflict-marker.nvim`
- Automatic indent width detection with `vim-sleuth`
- Illuminate symbols under the cursor with `vim-illuminate`
- Edit the filesystem like a buffer with `oil.nvim`
- Workspace diagnostics powered by `trouble.nvim`
- Split and join tree-sitter nodes with `treesj`
- Simple and clean statusline with `mini.statusline`
- Highlight hex color strings with `mini.hipatterns`
- Improved user interface with `dressing.nvim`

## Installation

1. Clone the repo into your `.config/nvim`
2. Open neovim
3. Make sure to install any necessary LSP servers

> Note: if LSP servers are missing, a warning will show when opening that file
> type

## Keybindings

### AI

| Key     |             Binding |
| :------ | ------------------: |
| Space i |   AI code insertion |
| Space I | Open AI chat window |
| Space A |      AI code action |

> Note: these features are in addition to the completion menu copilot
> integration, which requires no special keybindings

### Git

| Key         |                     Binding |
| :---------- | --------------------------: |
| Space g     | Open fugitive status window |
| Space G     |              Show diff view |
| ]g          |               Next git hunk |
| [g          |           Previous git hunk |
| ghs         |              Stage git hunk |
| ghu         |         Undo stage git hunk |
| ghr         |              Reset git hunk |
| Space Space |      Git blame current line |

### Autocompletion

| Key       |                      Binding |
| :-------- | ---------------------------: |
| Tab       |             Select next item |
| Shift Tab |         Select previous item |
| Enter     |                     Complete |
| Ctrl k    | Show function signature help |

> Note: although the completion window always shows, it does not select an item
> by default. To select the first item, press tab.

### File navigation

| Key   |                        Binding |
| :---- | -----------------------------: |
| -     |    Open tree / Go up directory |
| Enter |                      Open file |
| _     | Goto current working directory |
| \`    |  Set current working directory |
| :w    |                   Save changes |

> Note: the filesystem can be edited like any other vim buffer

### Tree-Sitter

| Key     |    Binding |
| :------ | ---------: |
| Space j | Split node |
| Space k |  Join node |

### LSP

| Key     |                     Binding |
| :------ | --------------------------: |
| gd      |             Goto definition |
| gy      |        Goto type definition |
| gr      |             Goto references |
| gi      |        Goto implementations |
| go      |         Goto incoming calls |
| gpd     |          Preview definition |
| gpy     |     Preview type definition |
| gpr     |          Preview references |
| gpi     |     Preview implementations |
| gP      |   Close all preview windows |
| g Space |  Switch C/C++ source/header |
| K       |         Hover documentation |
| Space r |               Rename symbol |
| Space a |                 Code action |
| Space d |            Show diagnostics |
| Space h |          Toggle inlay hints |
| \]d     |     Jump to next diagnostic |
| \[d     | Jump to previous diagnostic |

### Navigation

| Key    |                Binding |
| :----- | ---------------------: |
| Ctrl s |           Split window |
| Ctrl t |         Create new tab |
| Ctrl h |     Switch window left |
| Ctrl j |     Switch window down |
| Ctrl k |       Switch window up |
| Ctrl l |    Switch window right |
| Alt h  | Decrease window size x |
| Alt j  | Increase window size y |
| Alt k  | Decrease window size y |
| Alt l  | Increase window size x |
| H      |      Goto previous tab |
| L      |          Goto next tab |

## Markdown

| Key     |                                Binding |
| :------ | -------------------------------------: |
| Space m |  Open markdown preview of current file |
| Space M | Close markdown preview of current file |

## Custom Commands

| Command                   |                                    Description |
| :------------------------ | ---------------------------------------------: |
| `:Config`                 |                           Edit the config file |
| `:Indent <n>`             |       Set indent width to the specified amount |
| `:PeekOpen`               |          Open markdown preview of current file |
| `:PeekClose`              |         Close markdown preview of current file |
| `:LatexCompile`           | Compile the current latex file with `tectonic` |
| `:LatexCompileBackground` |        Silently compile the current latex file |

> Note: on the `tex` file type, `:LatexCompileBackground` is called
> automatically on file save to support live preview. For the latex commands to
> work, `tectonic` must be installed and available in the system path.
