-- nvim-cmp
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end)
	}),
	sources = cmp.config.sources({
		{ name = "nvim-lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			before = function(_, vim_item)
				return vim_item
			end
		})
	}
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
	}, {
		{ name = "buffer" },
	})
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" }
	}, {
		{ name = "cmdline" }
	})
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- gitsigns
require("gitsigns").setup()

-- lspconfig
local lspconfig = require("lspconfig")
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
lspconfig.rust_analyzer.setup({capabilities = capabilities})
lspconfig.jdtls.setup({capabilities = capabilities})
lspconfig.vimls.setup({capabilities = capabilities})
lspconfig.clangd.setup({
	cmd = {"clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++"},
	capabilities = capabilities
})
lspconfig.cmake.setup({capabilities = capabilities})
lspconfig.lua_ls.setup({capabilities = capabilities})
lspconfig.marksman.setup({capabilities = capabilities})
lspconfig.ocamllsp.setup({capabilities = capabilities})
lspconfig.texlab.setup({capabilities = capabilities})
lspconfig.wgsl_analyzer.setup({capabilities = capabilities})
lspconfig.tsserver.setup({capabilities = capabilities})

-- lspsaga
require("lspsaga").setup({
	lightbulb = {
		enable = false
	},
	code_action = {
		extend_gitsigns = true
	}
})

-- oil.nvim
require("oil").setup({})
if next(vim.fn.argv()) == nil then
	vim.cmd("Oil")
end

-- tree-sitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true
	},
	incremental_selection = {
		enable = true
	},
	indent = {
		enable = true
	},
	beacon = {
		enable = false
	}
})

-- KEYMAPS

-- oil.nvim
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- lspsaga
vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<Space>k", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<Space>d", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "<Space>p", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "<Space>y", "<cmd>Lspsaga goto_type_definition<CR>")
vim.keymap.set("n", "<Space>l", "<cmd>Lspsaga peek_type_definition<CR>")
vim.keymap.set("n", "<Space>f", "<cmd>Lspsaga finder<CR>")
vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<Space>i", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Space>o", "<cmd>Lspsaga outgoing_calls<CR>")
vim.keymap.set("n", "<Space>;", "<cmd>Lspsaga outline<CR>")

-- startup commands
vim.cmd("set nocompatible")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set noswapfile")
vim.cmd("set signcolumn=yes")
vim.cmd("set nowrap")

vim.cmd("colorscheme arob")
vim.cmd("set termguicolors")
