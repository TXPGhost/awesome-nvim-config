# awesome-nvim-config

Neovim configuration with a focus on simplicity, ease of use, and consistency.

![Screenshot of config](preview.png)

## Installation

1. Clone the repo into your `.config/nvim`
2. Open neovim

## Performance

Startup time is typically around 13 milliseconds on my machine. Most plugins are
lazy-loaded. You can view the startup time with `:Lazy profile`.

## Keybindings

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
| Space Space |          Blame current line |

### Autocompletion

| Key       |                               Binding |
| :-------- | ------------------------------------: |
| Tab       |  Invoke Completion / Select next item |
| Shift Tab | Invoke Copilot / Select previous item |
| Enter     |                              Complete |

### File navigation

| Key       |                       Binding |
| :-------- | ----------------------------: |
| -         |                Open file tree |
| Space -   | Open file tree and upadte CWD |
| Enter     |                     Open file |
| .         |                      Set root |
| Backspace |           Change directory up |
| `         |         Set current directory |
| g.        |      Toggle show hidden files |
| Space f   |          Search project files |
| Space /   |  Search project file contents |
| Ctrl r    |                 Refresh files |
| Ctrl p    |                Toggle preview |
| Ctrl t    |          Open file in new tab |
| Ctrl s    |   Open file in vertical split |
| O         |    Open in system application |

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

### Terminal

| Key        |       Binding |
| :--------- | ------------: |
| Ctrl Enter | Open terminal |

## Markdown

| Key     |       Binding |
| :------ | ------------: |
| Space p |  Open preview |
| Space P | Close preview |
