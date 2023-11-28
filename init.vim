call plug#begin()

" dependencies
Plug 'nvim-lua/plenary.nvim'

" neovim dev environment
Plug 'folke/neodev.nvim'

" themes
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'projekt0n/github-nvim-theme'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'smjonas/inc-rename.nvim'
Plug 'weilbith/nvim-code-action-menu'
Plug 'folke/trouble.nvim'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" graphviz
Plug 'liuchengxu/graphviz.vim'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" file explorer
Plug 'stevearc/oil.nvim'

" formatter
Plug 'stevearc/conform.nvim'

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
Plug 'rafamadriz/friendly-snippets'

" auto pairs
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'tpope/vim-surround'

" snippets (for autocompletion)
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" autocompletion icons
Plug 'onsails/lspkind.nvim'

" git integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" icons
Plug 'nvim-tree/nvim-web-devicons'

" latex
Plug 'lervag/vimtex'

" automatic tab type detection
Plug 'tpope/vim-sleuth'

" rust
Plug 'simrat39/rust-tools.nvim'
Plug 'Saecki/crates.nvim'

" java
Plug 'mfussenegger/nvim-jdtls'

" markdown preview
Plug 'cloudsftp/peek.nvim'

call plug#end()

" run config file
source ~/.config/nvim/config.lua
