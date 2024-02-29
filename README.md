# awesome-nvim-config

The awesomest neovim config out there.

![Screenshot of config](preview.png)

## Installation

1. Clone the repo into your `.config/nvim`
2. Open Neovim and run `:PlugInstall`

## Performance

Startup time is typically sub-20 millisecond (~15 on average). View startup time
with the `:StartupTime` command.

## Keybindings

### Git

| Key         |                     Binding |
| :---------- | --------------------------: |
| ?           | Open fugitive status window |
| g?          |              Show diff view |
| ]h          |                   Next hunk |
| [h          |               Previous hunk |
| Space Space |                Preview hunk |
| ghs         |                  Stage hunk |
| ghu         |             Undo stage hunk |
| ghr         |                  Reset hunk |

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

| Key     |                                 Binding |
| :------ | --------------------------------------: |
| gd      |                         Goto definition |
| gy      |                    Goto type definition |
| gr      |                         Goto references |
| gi      |                    Goto implementations |
| Space r |                           Rename symbol |
| Space k |                     Hover documentation |
| Space a |                             Code action |
| Space d |               Show document diagnostics |
| Space D |              Show workspace diagnostics |
| \]d     |                 Jump to next diagnostic |
| \[d     |             Jump to previous diagnostic |
| Ctrl a  | Jump to next snippet mark (Insert mode) |

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

## Additional Features

When searching the buffer using `/`, use `@` to search LSP document symbols.
