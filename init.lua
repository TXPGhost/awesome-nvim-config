-- vim-plug
---@diagnostic disable-next-line: param-type-mismatch
vim.call("plug#begin")
local plug = vim.fn["plug#"]

-- dependencies
plug("nvim-lua/plenary.nvim")

-- neovim dev environment
plug("folke/neodev.nvim")

-- startup time
plug("dstein64/vim-startuptime")

-- themes
plug("folke/tokyonight.nvim")
plug("rebelot/kanagawa.nvim")
plug("projekt0n/github-nvim-theme")
plug("catppuccin/nvim")
plug("andreasvc/vim-256noir")
plug("kepano/flexoki-neovim")
plug("NLKNguyen/papercolor-theme")
plug("bluz71/vim-moonfly-colors")
plug("ayu-theme/ayu-vim")

-- theme builder
plug("rktjmp/lush.nvim")

-- lualine
plug("nvim-lualine/lualine.nvim")

-- comment toggling
plug("tpope/vim-commentary")

-- LSP
plug("neovim/nvim-lspconfig")
plug("ray-x/lsp_signature.nvim")
plug("smjonas/inc-rename.nvim")
plug("weilbith/nvim-code-action-menu")
plug("folke/trouble.nvim")

-- graphviz
plug("liuchengxu/graphviz.vim")

-- tree-sitter
plug("nvim-treesitter/nvim-treesitter", "{do: :TSUpdate}")
plug("nvim-treesitter/nvim-treesitter-textobjects")

-- file explorer
plug("stevearc/oil.nvim")

-- formatter
plug("stevearc/conform.nvim")

-- telescope
plug("nvim-telescope/telescope.nvim", "{ branch: 0.1.x }")
plug(
	"nvim-telescope/telescope-fzf-native.nvim",
	"{ do: cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build }"
)

-- autocompletion
plug("neovim/nvim-lspconfig")
plug("hrsh7th/cmp-nvim-lsp")
plug("hrsh7th/cmp-buffer")
plug("hrsh7th/cmp-path")
plug("hrsh7th/cmp-cmdline")
plug("hrsh7th/nvim-cmp")
plug("rafamadriz/friendly-snippets")

-- auto pairs
plug("windwp/nvim-autopairs")
plug("windwp/nvim-ts-autotag")
plug("tpope/vim-surround")

-- snippets (for autocompletion)
plug("hrsh7th/cmp-vsnip")
plug("hrsh7th/vim-vsnip")

-- autocompletion icons
plug("onsails/lspkind.nvim")

-- git integration
plug("lewis6991/gitsigns.nvim")
plug("tpope/vim-fugitive")
plug("sindrets/diffview.nvim")

-- icons
plug("nvim-tree/nvim-web-devicons")

-- latex
plug("lervag/vimtex")

-- automatic tab type detection
plug("tpope/vim-sleuth")

-- rust
plug("simrat39/rust-tools.nvim")
plug("Saecki/crates.nvim")

-- java
plug("mfussenegger/nvim-jdtls")

-- markdown preview
plug("cloudsftp/peek.nvim")

---@diagnostic disable-next-line: param-type-mismatch
vim.call("plug#end")

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

-- enable undercurl support for wezterm
vim.cmd([[let &t_Cs = "\e[60m"]])
vim.cmd([[let &t_Ce = "\e[24m"]])

-- disable startup message
vim.opt.shm:append("I")

-- add wgsl filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = { "*.wgsl" }, command = "set filetype=wgsl" })

-- configure diagnostics
vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })

vim.diagnostic.config({ severity_sort = true, virtual_text = { prefix = "" } })

-- enable format on save
local conform = require("conform")
conform.setup({
	notify_on_error = false,
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
		ocaml = { "ocamlformat" },
		_ = { "trim_whitespace" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		["ocamlformat"] = {
			command = "ocamlformat",
			args = { "--doc-comments=before", "--wrap-comments", "--parse-docstrings", "--name", "$FILENAME", "-" },
		},
		["clang-format"] = {
			command = "clang-format",
			args = { "--assume-filename=$FILENAME" },
		},
	},
})

-- lualine
require("lualine").setup({})

-- oil
require("oil").setup({})
vim.keymap.set("n", "-", "<cmd>Oil<cr>zz", { desc = "Open parent directory" })

-- nvim-autopairs
local npairs = require("nvim-autopairs")
npairs.setup({
	check_ts = true,
})

local rule = require("nvim-autopairs.rule")

npairs.add_rule(rule("$", "$", "tex"):with_move(function(opts)
	return opts.next_char == opts.char
end))

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
		["<cr>"] = cmp.mapping.confirm(),
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
	}, {
		-- { name = "buffer" }
	}),
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
local gitsigns = require("gitsigns")
gitsigns.setup({})

-- neodev
require("neodev").setup({})

-- lspsignature
require("lsp_signature").setup({
	hint_prefix = " ",
	handler_opts = {
		border = "none",
	},
})

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
lspconfig.taplo.setup({ capabilities = capabilities })
lspconfig.dotls.setup({ capabilities = capabilities })
lspconfig.hls.setup({ capabilities = capabilities })
lspconfig.glslls.setup({ capabilities = capabilities })

-- rust-tools
local rust_tools = require("rust-tools")
rust_tools.setup({
	tools = {
		inlay_hints = {
			highlight = "Comment",
		},
	},
	server = {
		standalone = true,
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
	crate_graph = {
		backend = "x11",
		output = nil,
		full = true,
	},
})

-- rust crates
require("crates").setup({
	src = {
		cmp = {
			enabled = true,
		},
	},
})

-- trouble
require("trouble").setup({
	height = 20,
	padding = false,
	auto_close = true,
	auto_jump = {
		"lsp_definitions",
		"lsp_type_definitions",
		"lsp_references",
		"lsp_implementations",
		"document_diagnostics",
		"workspace_diagnostics",
	},
})

-- code actions
vim.g.code_action_menu_show_action_kind = false
vim.g.code_action_menu_show_details = false

-- tree-sitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			scope_incremental = "<cr>",
			node_incremental = "<Tab>",
			node_decremental = "<S-Tab>",
		},
	},
	indent = {
		enable = false,
	},
	beacon = {
		enable = false,
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"css",
			"lua",
			"xml",
			"php",
			"markdown",
		},
	},
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99999

-- vimtex
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src@line@tex"
vim.g.vimtex_compiler_method = "tectonic"

-- incremental rename
require("inc_rename").setup({})

-- KEYMAPS

-- generic
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>TroubleClose<cr>")
vim.keymap.set("n", "<c-cr>", "<cmd>tabnew<cr><cmd>terminal<cr>i")
vim.keymap.set("n", "<c-o>", "<c-o>zz")
vim.keymap.set("n", "<c-i>", "<c-i>zz")

-- telescope
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
		},
	},
})

vim.keymap.set("n", "<space>F", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<space>f", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>")

vim.keymap.set("n", "<space>;", "<cmd>Telescope lsp_document_symbols<cr>")
vim.keymap.set("n", "<space>:", "<cmd>Telescope lsp_workspace_symbols<cr>")

-- treesitter-textobjects
local function mktextobj(bind, obj)
	vim.keymap.set({ "n", "v" }, "]" .. bind, "<cmd>TSTextobjectGotoNextStart " .. obj .. "<cr><cmd>norm zz<cr>")
	vim.keymap.set({ "n", "v" }, "[" .. bind, "<cmd>TSTextobjectGotoPreviousStart" .. obj .. "<cr><cmd>norm zz<cr>")
end

mktextobj("f", "@function.outer")
mktextobj("c", "@class.outer")
mktextobj("s", "@statement.outer")

-- git
vim.keymap.set("n", "<space>g", "<cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "gb", "<cmd>Git blame<cr>")
vim.keymap.set("n", "gB", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "?", "<cmd>Git<cr><cmd>wincmd L<cr>")
vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit!<cr>")

vim.keymap.set("n", "<space>k", function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<space>d", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<space>D", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<space>a", "<cmd>CodeActionMenu<cr>")

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end)

vim.keymap.set("n", "<space>r", ":IncRename ")
vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>") -- IDEA: open in new tab if different file
vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>")
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")

vim.keymap.set("n", "<c-t>", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<c-h>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>tabnext<cr>")

-- startup commands
vim.opt.compatible = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.mousescroll = "ver:5,hor:6"

vim.opt.termguicolors = true

-- colorscheme
vim.cmd.colorscheme("flexoki-dark")
do
	-- enable undercurl
	vim.cmd.hi("DiagnosticUnderlineOk", "gui=undercurl")
	vim.cmd.hi("DiagnosticUnderlineInfo", "gui=undercurl")
	vim.cmd.hi("DiagnosticUnderlineHint", "gui=undercurl")
	vim.cmd.hi("DiagnosticUnderlineWarn", "gui=undercurl")
	vim.cmd.hi("DiagnosticUnderlineError", "gui=undercurl")

	-- fix gitsings sign column
	vim.cmd.hi("GitSignsAdd", "guifg=#879a39", "guibg=#100f0f")
	vim.cmd.hi("GitSignsChange", "guifg=#8b7ec8", "guibg=#100f0f")
	vim.cmd.hi("GitSignsDelete", "guifg=#d14d41", "guibg=#100f0f")
end

-- configure neovide, if enabled
if vim.g.neovide then
	vim.opt.guifont = "Monaspace Neon ExtraLight:#e-subpixelantialias:h9.5"

	local default_scale_factor = 1.1

	vim.g.neovide_scale_factor = default_scale_factor

	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_refresh_rate = 144

	vim.g.neovide_fullscreen = true

	vim.keymap.set("n", "<c-=>", function()
		if vim.g.neovide_scale_factor < 3 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
		end
	end)

	vim.keymap.set("n", "<c-->", function()
		if vim.g.neovide_scale_factor > 0.5 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
		end
	end)

	vim.keymap.set("n", "<c-0>", function()
		vim.g.neovide_scale_factor = default_scale_factor
	end)
end
