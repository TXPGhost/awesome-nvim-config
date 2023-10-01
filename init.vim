call plug#begin()

" dependencies
Plug 'nvim-lua/plenary.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter'

" file explorer
Plug 'stevearc/oil.nvim'

" telescope
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" snippets (for autocompletion)
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" autocompletion icons
Plug 'onsails/lspkind.nvim'

" git integration
Plug 'lewis6991/gitsigns.nvim'

" colorscheme
Plug 'projekt0n/github-nvim-theme'
Plug 'tiagovla/tokyodark.nvim'

" icons
Plug 'nvim-tree/nvim-web-devicons'

" better LSP
Plug 'nvimdev/lspsaga.nvim'

call plug#end()

" run config file
source ~/.config/nvim/config.lua
