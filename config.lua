-- set help window to vertical split
vim.cmd("autocmd FileType help wincmd L")

-- add new filetypes
vim.cmd("autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl")

-- set cursorline for insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd("set cursorline")
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.cmd("set nocursorline")
	end,
})

-- set diagnostic icon
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- format on save
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		typescript = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		vue = { "prettierd" },
		markdown = { "prettierd" },
		yaml = { "prettierd" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		lua = { "stylua" },
		tex = { "latexindent" },
		ocaml = { "ocamlformat" },
		java = { "jdtls" },
		_ = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		ocamlformat = {
			command = "ocamlformat",
			args = { "--doc-comments=before", "--wrap-comments", "--parse-docstrings", "--name", "$FILENAME", "-" },
		},
	},
})

-- nvim-cmp
local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
		["<CR>"] = cmp.mapping.confirm(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "crates" },
	}, { { name = "buffer" } }),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- markdown preview
local peek = require("peek")
peek.setup({})
vim.api.nvim_create_user_command("MarkdownPreviewOpen", peek.open, {})
vim.api.nvim_create_user_command("MarkdownPreviewClose", peek.close, {})

-- gitsigns
require("gitsigns").setup({})

-- lspconfig
local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({
	cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++" },
	capabilities = capabilities,
})
lspconfig.cmake.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.marksman.setup({ capabilities = capabilities })
lspconfig.ocamllsp.setup({
	cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
	capabilities = capabilities,
})
lspconfig.texlab.setup({ capabilities = capabilities })
lspconfig.wgsl_analyzer.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.lemminx.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })

-- rust-tools
local rust_tools = require("rust-tools")
rust_tools.setup({
	tools = {
		inlay_hints = {
			highlight = "Comment",
		},
	},
})

-- crates
require("crates").setup({
	src = {
		cmp = {
			enabled = true,
		},
	},
})

-- lspsaga
require("lspsaga").setup({
	lightbulb = {
		enable = false,
	},
	code_action = {
		extend_gitsigns = true,
	},
	symbol_in_winbar = {
		enable = false,
	},
})

-- neo-tree
local neo_tree = require("neo-tree")
neo_tree.setup({
	window = {
		auto_expand_width = true,
	},
	sources = {
		"filesystem",
		"document_symbols",
	},
	popup_border_style = "rounded",
	close_if_last_window = true,
	filesystem = {
		window = {
			mappings = {
				["-"] = "navigate_up",
				["+"] = "set_root",
			},
		},
	},
	document_symbols = {
		close_if_last_window = true,
		kinds = {
			Function = { hl = "@function" },
			Constructor = { hl = "@function" },
			Method = { hl = "@function" },

			Namespace = { hl = "@include" },
			Module = { hl = "@include" },
			Package = { hl = "@include" },

			Struct = { hl = "@storageclass" },
			Enum = { hl = "@storageclass" },
			EnumMember = { hl = "@constant" },
			Object = { hl = "@storageclass" },
			Field = { hl = "@type" },

			Array = { hl = "@constant" },
			String = { hl = "@string" },
			Constant = { hl = "@constant" },
		},
	},
})

-- tree-sitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<Tab>",
			node_decremental = "<S-Tab>",
		},
	},
	indent = {
		enable = true,
	},
	beacon = {
		enable = false,
	},
})
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.cmd("set foldlevel=99999")

-- vimtex
vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src@line@tex'")

vim.cmd("let g:vimtex_compiler_method = 'tectonic'")

-- KEYMAPS

-- generic
vim.cmd("noremap > >>")
vim.cmd("noremap < <<")
vim.cmd("vnoremap > >gv")
vim.cmd("vnoremap < <gv")

vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")
vim.keymap.set("v", "<CR>", "")

-- telescope
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
		},
	},
})

vim.keymap.set("n", "<Space>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

-- treesitter-textobjects
local function mktextobj(bind, obj)
	vim.keymap.set({ "n", "v" }, "]" .. bind, "<cmd>TSTextobjectGotoNextStart " .. obj .. "<CR><cmd>norm zz<CR>")
	vim.keymap.set({ "n", "v" }, "[" .. bind, "<cmd>TSTextobjectGotoPreviousStart" .. obj .. "<CR><cmd>norm zz<CR>")
end

mktextobj("f", "@function.outer")
mktextobj("c", "@class.outer")
mktextobj("s", "@statement.outer")

vim.keymap.set("n", "<Tab>", "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>")

-- neo-tree
vim.keymap.set("n", "-", "<cmd>Neotree filesystem reveal<CR>")
vim.keymap.set("n", ";", "<cmd>Neotree document_symbols<CR>")
vim.keymap.set("n", "<BS>", "<cmd>Neotree close<CR>")

-- fugitive
vim.keymap.set("n", "?", "<cmd>Gvdiffsplit<CR>")

-- gitsigns
vim.keymap.set("n", "<Space>b", "<cmd>Gitsigns blame_line<CR>")

vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")

-- lspsaga
vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>")
vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")

vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<Space>k", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<Space>i", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Space>o", "<cmd>Lspsaga outgoing_calls<CR>")
vim.keymap.set("n", "<Space>d", "<cmd>Lspsaga show_buf_diagnostics<CR>")
vim.keymap.set("n", "<Space>D", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

-- startup commands
vim.cmd("set nocompatible")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set noswapfile")
vim.cmd("set signcolumn=yes")
vim.cmd("set nowrap")

vim.cmd("colorscheme boop")
vim.cmd("set termguicolors")
