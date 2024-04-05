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
| ?           | Open fugitive status window |
| g?          |              Show diff view |
| ]h          |                   Next hunk |
| [h          |               Previous hunk |
| ghs         |                  Stage hunk |
| ghu         |             Undo stage hunk |
| ghr         |                  Reset hunk |
| Space g     |               Change branch |
| Space Space |                Preview hunk |

### Autocompletion

| Key       |                               Binding |
| :-------- | ------------------------------------: |
| Tab       |  Invoke Completion / Select next item |
| Shift Tab | Invoke Copilot / Select previous item |
| Enter     |                              Complete |

### Copilot

| Key   |                  Binding |
| :---- | -----------------------: |
| Alt ] |     Show next suggestion |
| Alt ] | Show previous suggestion |
| Alt l |        Accept suggestion |
| Alt m |        Reject suggestion |

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
| Space j   |              Search jumplist |
| Space /   | Search project file contents |
| Ctrl r    |                Refresh files |
| Ctrl p    |               Toggle preview |
| Ctrl t    |         Open file in new tab |
| Ctrl s    |  Open file in vertical split |
| gx        |     Open in external program |

### Tree-Sitter

| Key       |          Binding |
| :-------- | ---------------: |
| Enter     |   Init selection |
| Tab       |   Grow selection |
| Shift Tab | Shrink Selection |
| Ctrl j    |       Split code |
| Ctrl k    |        Join code |

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

| Key    |              Binding |
| :----- | -------------------: |
| Ctrl t |       Create new tab |
| J      |    Goto previous tab |
| K      |        Goto next tab |
| L      |     Goto next window |
| H      | Goto previous window |

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
| Space r |                       Preview current fold |
| ]f      |                      Goto next closed fold |
| [f      |                  Goto previous closed fold |

## Selection

| Key |   Binding |
| :-- | --------: |
| >   |    Indent |
| <   |    Dedent |
| .   |   Move up |
| ,   | Move down |

## Pairs

| Key   |                      Binding |
| :---- | ---------------------------: |
| Alt l |      Fast warp next end pair |
| Alt h | Undo fast warp next end pair |
