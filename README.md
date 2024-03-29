# awesome-nvim-config

The awesomest neovim config out there.

![Screenshot of config](preview.png)

## Installation

1. Clone the repo into your `.config/nvim`
2. Open neovim

## Performance

Startup time is typically sub-20 millisecond (~12 on average). View startup time
with the `:StartupTime` command.

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
| Space Space |                Preview hunk |

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

### Tree-Sitter

| Key       |          Binding |
| :-------- | ---------------: |
| Enter     |   Init selection |
| Tab       |   Grow selection |
| Shift Tab | Shrink Selection |
| Ctrl j    |       Split code |
| Ctrl k    |        Join code |

### LSP

| Key     |                                  Binding |
| :------ | ---------------------------------------: |
| gd      |                          Goto definition |
| gy      |                     Goto type definition |
| gr      |                          Goto references |
| gi      |                     Goto implementations |
| gpd     |                       Preview definition |
| gpy     |                  Preview type definition |
| gpr     |                       Preview references |
| gpi     |                  Preview implementations |
| gP      |                Close all preview windows |
| gtd     |               Goto definition in new tab |
| gty     |          Goto type definition in new tab |
| gtr     |               Goto references in new tab |
| gti     |          Goto implementations in new tab |
| gsd     |      Goto definition in horizontal split |
| gsy     | Goto type definition in horizontal split |
| gsr     |      Goto references in horizontal split |
| gsi     | Goto implementations in horizontal split |
| gvd     |        Goto definition in vertical split |
| gvy     |   Goto type definition in vertical split |
| gvr     |        Goto references in vertical split |
| gvi     |   Goto implementations in vertical split |
| Space r |                            Rename symbol |
| Space k |                      Hover documentation |
| Space a |                              Code action |
| Space d |                Show document diagnostics |
| Space D |               Show workspace diagnostics |
| \]d     |                  Jump to next diagnostic |
| \[d     |              Jump to previous diagnostic |
| Ctrl a  |  Jump to next snippet mark (Insert mode) |

### Tabs

| Key    |           Binding |
| :----- | ----------------: |
| Ctrl t |    Create new tab |
| Ctrl h | Goto previous tab |
| Ctrl l |     Goto next tab |

### Terminal

| Key        |            Binding |
| :--------- | -----------------: |
| Ctrl Enter |      Open terminal |
| Ctrl a     | Exit terminal mode |

## Folds

| Key |                                    Binding |
| :-- | -----------------------------------------: |
| zR  |                             Open all folds |
| zM  |                            Close all folds |
| zr  | Open all folds except comments and imports |
| zm  |                 Close all folds with level |
| K   |                       Preview current fold |
| ]f  |                      Goto next closed fold |
| [f  |                  Goto previous closed fold |

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
| Alt e |      Fast warp next end pair |
| Alt E | Undo fast warp next end pair |
