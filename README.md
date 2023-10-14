# awesome-nvim-config

## Installation
1. Clone the repo into your `.config/nvim`
2. Open Neovim and run `:PlugInstall`

## Keybindings

### General
| Key | Binding |
|:--|--:|
|\\ |Search in current buffer|

### Git
| Key | Binding |
|:--|--:|
|?|Open split diff view|
|Space b|Blame current line|
|]h|Next hunk|
|[h|Previous hunk|

### File tree
| Key | Binding |
|:--|--:|
|-|Open file tree/navigate up|
|+|Navigate in|
|Backspace|Close file tree|
|w|Open file/folder|
|H|Toggle hidden|
|Ctrl f|Search for files|

### Tree-Sitter
| Key | Binding |
|:--|--:|
|Enter Enter|Init selection|
|(Visual) Tab|Grow selection|
|(Visual) Shift Tab|Shrink Selection|
|(Normal) Tab|Goto next parameter|
|(Normal) Shift Tab|Goto previous parameter|
|\]f|Jump to next function|
|\[f|Jump to previous function|
|Enter f|Select current function|
|\]c|Jump to next class|
|\[c|Jump to previous class|
|Enter c|Select current class|
|\]s|Jump to next statement|
|\[s|Jump to previous statement|
|Enter s|Select current statement|

### LSP
| Key | Binding |
|:--|--:|
|;|Toggle document symbols|
|gd|Goto definition|
|gy|Goto type definition|
|gr|Goto references|
|Space r|Rename symbol|
|Space k|Hover documentation|
|Space f|Open finder|
|Space a|Code action|
|Space i|View incoming calls|
|Space o|View outgoing calls|
|Space d|Show workspace diagnostics|
|Space D|Show workspace diagnostics|
|\]d|Jump to next diagnostic|
|\[d|Jump to previous diagnostic|

## LaTeX
| Key | Binding |
|:--|--:|
|\ll|Compile (using `tectonic`)|
|dsc|Delete surroinding command|
|dse|Delete surrounding environment|
|]]|Close surrounding environment (insert mode only)|

## Fold
| Key | Binding |
|:--|--:|
|zc|Close fold|
|zo|Open fold|
|zM|Close all folds|
|zR|Open all folds|
