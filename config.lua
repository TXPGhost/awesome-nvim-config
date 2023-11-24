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
vim.diagnostic.config({ severity_sort = true, virtual_text = { prefix = "" } })

-- set mouse scroll
vim.opt.mousescroll = "ver:1,hor:2"

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

-- oil
require("oil").setup({})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

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
})

-- rust crates
require("crates").setup({
	src = {
		cmp = {
			enabled = true,
		},
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
			init_selection = "<CR>",
			scope_incremental = "<CR>",
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
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99999

-- vimtex
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src@line@tex"
vim.g.vimtex_compiler_method = "tectonic"

-- KEYMAPS

-- generic
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")
vim.keymap.set("v", "<CR>", "")
vim.keymap.set("n", "`", "<cmd>!make run<CR>")

-- telescope
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
		},
	},
})

vim.keymap.set("n", "<Space>F", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Space>f", "<cmd>Telescope buffers<CR>")

vim.keymap.set("n", "<Space>;", "<cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<Space>:", "<cmd>Telescope lsp_workspace_symbols<CR>")

-- treesitter-textobjects
local function mktextobj(bind, obj)
	vim.keymap.set({ "n", "v" }, "]" .. bind, "<cmd>TSTextobjectGotoNextStart " .. obj .. "<CR><cmd>norm zz<CR>")
	vim.keymap.set({ "n", "v" }, "[" .. bind, "<cmd>TSTextobjectGotoPreviousStart" .. obj .. "<CR><cmd>norm zz<CR>")
end

mktextobj("f", "@function.outer")
mktextobj("c", "@class.outer")
mktextobj("s", "@statement.outer")

-- git
vim.keymap.set("n", "<Space>g", "<cmd>Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<Space>G", "<cmd>Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "<Space>u", "<cmd>Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("n", "?", "<cmd>Gitsigns toggle_deleted<CR><cmd>Gitsigns toggle_linehl<CR>")
vim.keymap.set("n", "gh", "<cmd>Git blame<CR>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "gs", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit<CR>")
vim.keymap.set("n", "gb", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "gc", "<cmd>Telescope git_commits<CR>")

vim.keymap.set("n", "<Space>k", function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<Space>d", "<cmd>Telescope diagnostics<CR>")
vim.keymap.set("n", "<Space>a", "<cmd>CodeActionMenu<CR>")

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end)

vim.keymap.set("n", "<space>s", "<cmd>telescope lsp_references<cr>")
vim.keymap.set("n", "<space>r", function()
	vim.lsp.buf.rename()
end)
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", "gy", function()
	vim.lsp.buf.type_definition()
end)

-- startup commands
vim.opt.compatible = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.signcolumn = "no"
vim.opt.wrap = false

vim.cmd.colorscheme("kanagawa")
vim.opt.termguicolors = true

-- statusline
vim.opt.statusline = [[%<%f %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P]]
