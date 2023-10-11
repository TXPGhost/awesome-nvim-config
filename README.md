# awesome-nvim-config

## Installation
1. Clone the repo into your `.config/nvim`
2. Open Neovim and run `:PlugInstall`

## Keybindings

### Git
| Key | Binding |
|:--|--:|
|?|Toggle diff view|
|Space b|Blame current line|

### File picker
| Key | Binding |
|:--|--:|
|-|Open file picker, goto parent directory|

### LSP
| Key | Binding |
|:--|--:|
|Space r|Rename symbol|
|Space k|Hover documentation|
|Space d|Goto definition|
|Space p|Peek definition|
|Space y|Goto type definition|
|Space l|Peek type definition|
|Space f|Open finder|
|Space a|Code action|
|Space i|View incoming calls|
|Space o|View outgoing calls|
|Space g|Show workspace diagnostics|
|;|Open outline|
|Enter|Begin selection|
|Tab|Grow selection|
|Shift Tab|Shrink Selection|

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
