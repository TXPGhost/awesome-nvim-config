# awesome-nvim-config

The awesomest neovim config out there.

![Screenshot of config](preview.png)

## Installation

1. Clone the repo into your `.config/nvim`
2. Open neovim

## Performance

Startup time is typically around 20 milliseconds. You can view the startup time
with `:Lazy profile`.

## Keybindings

### Git

| Key         |                     Binding |
| :---------- | --------------------------: |
| Space g     | Open fugitive status window |
| gs          |              Show diff view |
| ]h          |                   Next hunk |
| [h          |               Previous hunk |
| ghs         |                  Stage hunk |
| ghu         |             Undo stage hunk |
| ghr         |                  Reset hunk |
| Space Space |                Preview hunk |

### Autocompletion

| Key       |                               Binding |
| :-------- | ------------------------------------: |
| Tab       |                     Invoke Completion |
| Shift Tab | Invoke Copilot / Select previous item |
| Enter     |           Complete / Select next item |

### File navigation

| Key       |                      Binding |
| :-------- | ---------------------------: |
| -         |   Open file tree/navigate up |
| Enter     |        Open file/navigate in |
| Backspace |              Close file tree |
| `         |        Set current directory |
| g.        |     Toggle show hidden files |
| Space f   |         Search project files |
| Space b   |       Search project buffers |
| Space /   | Search project file contents |
| Ctrl r    |                Refresh files |
| Ctrl p    |               Toggle preview |
| Ctrl t    |         Open file in new tab |
| Ctrl s    |  Open file in vertical split |
| gx        |     Open in external program |

### Tree-Sitter

| Key       |                   Binding |
| :-------- | ------------------------: |
| Enter     |            Init selection |
| Tab       |            Grow selection |
| Shift Tab |          Shrink Selection |
| Ctrl j    |                Split code |
| Ctrl k    |                 Join code |
| vaf       |     Select outer function |
| vif       |     Select inner function |
| vac       |        Select outer class |
| vic       |        Select inner class |
| ]f        |     Jump to next function |
| [f        | Jump to previous function |
| ]c        |        Jump to next class |
| [c        |    Jump to previous class |

### LSP

| Key     |                     Binding |
| :------ | --------------------------: |
| gd      |             Goto definition |
| gy      |        Goto type definition |
| gr      |             Goto references |
| gi      |        Goto implementations |
| gpd     |          Preview definition |
| gpy     |     Preview type definition |
| gpr     |          Preview references |
| gpi     |     Preview implementations |
| gP      |   Close all preview windows |
| Space r |               Rename symbol |
| Space k |         Hover documentation |
| Space a |                 Code action |
| Space d |   Show document diagnostics |
| Space D |  Show workspace diagnostics |
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

| Key        |            Binding |
| :--------- | -----------------: |
| Ctrl Enter |      Open terminal |
| Ctrl a     | Exit terminal mode |

## Folds

| Key     |                                    Binding |
| :------ | -----------------------------------------: |
| zR      |                             Open all folds |
| zM      |                            Close all folds |
| zr      | Open all folds except comments and imports |
| zm      |                 Close all folds with level |
| Space k |                       Preview current fold |
| ]c      |                      Goto next closed fold |
| [c      |                  Goto previous closed fold |

## Pairs

| Key   |                      Binding |
| :---- | ---------------------------: |
| Alt 0 |      Fast warp next end pair |
| Alt 9 | Undo fast warp next end pair |
