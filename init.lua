---@diagnostic disable-next-line: param-type-mismatch
vim.cmd("let start_time = reltime()")

local time_names = {}
local function log_time(name)
	vim.cmd("let t_" .. name .. " = reltimefloat(reltime(start_time))")
	table.insert(time_names, "t_" .. name)
end

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
plug("rebelot/kanagawa.nvim")

-- lualine
plug("nvim-lualine/lualine.nvim")
plug("mawkler/modicator.nvim")

-- comment toggling
plug("tpope/vim-commentary")

-- better fold
plug("kevinhwang91/promise-async")
plug("kevinhwang91/nvim-ufo")

-- LSP
plug("neovim/nvim-lspconfig")
plug("ray-x/lsp_signature.nvim")
plug("smjonas/inc-rename.nvim")
plug("weilbith/nvim-code-action-menu")
plug("folke/trouble.nvim")
plug("linrongbin16/lsp-progress.nvim")
plug("rmagatti/goto-preview")

-- graphviz
plug("liuchengxu/graphviz.vim")

-- tree-sitter
plug("nvim-treesitter/nvim-treesitter")
plug("nvim-treesitter/nvim-treesitter-textobjects")

-- file explorer
plug("stevearc/oil.nvim")

-- formatter
plug("stevearc/conform.nvim")

-- telescope
plug("nvim-telescope/telescope.nvim")

-- autocompletion
plug("neovim/nvim-lspconfig")
plug("hrsh7th/cmp-nvim-lsp")
plug("hrsh7th/cmp-path")
plug("hrsh7th/cmp-cmdline")
plug("hrsh7th/nvim-cmp")
plug("rafamadriz/friendly-snippets")

-- inlay hints
plug("lvimuser/lsp-inlayhints.nvim")

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
plug("rhysd/conflict-marker.vim")

-- icons
plug("nvim-tree/nvim-web-devicons")

-- latex
plug("lervag/vimtex")

-- automatic tab type detection
plug("tpope/vim-sleuth")

-- rust
plug("mrcjkb/rustaceanvim")
plug("Saecki/crates.nvim")

-- markdown
plug("cloudsftp/peek.nvim")

-- colorizer
plug("norcalli/nvim-colorizer.lua")

---@diagnostic disable-next-line: param-type-mismatch
vim.call("plug#end")

log_time("vimplug")

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

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

log_time("misc")

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
		haskell = { "ormolu" },
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

log_time("conform")

-- lsp progress
require("lsp-progress").setup({})

log_time("lsp_progress")

-- lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { require("lsp-progress").progress, "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

log_time("lualine")

-- oil
require("oil").setup({
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		-- ["<C-h>"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		-- ["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	use_default_keymaps = false,
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>zz", { desc = "Open parent directory" })

log_time("oil")

-- nvim-autopairs
local npairs = require("nvim-autopairs")
npairs.setup({
	check_ts = true,
})

local rule = require("nvim-autopairs.rule")

npairs.add_rule(rule("$", "$", "tex"):with_move(function(opts)
	return opts.next_char == opts.char
end))

log_time("autopairs")

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

log_time("cmp")

-- markdown preview
local peek = require("peek")
peek.setup({})
vim.api.nvim_create_user_command("MarkdownPreviewOpen", peek.open, {})
vim.api.nvim_create_user_command("MarkdownPreviewClose", peek.close, {})

log_time("markdown")

-- config quick edit
vim.api.nvim_create_user_command("Config", function()
	vim.cmd("e ~/.config/nvim/init.lua")
end, {})
vim.api.nvim_create_user_command("ConfigReload", function()
	vim.cmd("so ~/.config/nvim/init.lua")
end, {})

log_time("configautocmd")

-- gitsigns
local gitsigns = require("gitsigns")
gitsigns.setup({
	update_debounce = 0,
})

log_time("gitsigns")

-- neodev
require("neodev").setup({})

log_time("neodev")

-- lspsignature
require("lsp_signature").setup({
	hint_prefix = " ",
	handler_opts = {
		border = "none",
	},
})

log_time("lspsignature")

-- goto-preview
local goto_preview = require("goto-preview")
goto_preview.setup()

log_time("gotopreview")

-- lspconfig
local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.cmake.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
	capabilities = capabilities,
})
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
lspconfig.pylsp.setup({ capabilities = capabilities })

log_time("lspconfig")

-- lsp inlay hints
require("lsp-inlayhints").setup({
	inlay_hints = {
		type_hints = {
			remove_colon_start = true,
		},
	},
})
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})

log_time("lspinlayhints")

-- rust crates
require("crates").setup({
	src = {
		cmp = {
			enabled = true,
		},
	},
})

log_time("crates")

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

log_time("truoble")

-- code actions
vim.g.code_action_menu_show_action_kind = false
vim.g.code_action_menu_show_details = false

log_time("actions")

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

log_time("treesitter")

-- ufo
local ufo = require("ufo")
ufo.setup()

log_time("ufo")

-- vimtex
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src@line@tex"
vim.g.vimtex_compiler_method = "tectonic"

log_time("vimtex")

-- incremental rename
require("inc_rename").setup({})

log_time("increname")

-- colorizer
vim.opt.termguicolors = true
require("colorizer").setup({ "*" }, {
	RGB = true,
	RRGGBB = true,
	RRGGBBAA = true,
	names = true,
	rgb_fn = true,
	hsl_fn = true,
	css = true,
	css_fn = true,
	mode = "background",
})
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead", "BufWrite" },
	{ pattern = { "*" }, command = "ColorizerAttachToBuffer" }
)

log_time("colorizer")

-- KEYMAPS

-- generic
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>TroubleClose<cr>")
vim.keymap.set("n", "<c-cr>", "<cmd>terminal<cr>i")
vim.keymap.set("t", "<c-a>", "<c-\\><c-n>")
vim.keymap.set("n", "<c-o>", "<c-o>zz")
vim.keymap.set("n", "<c-i>", "<c-i>zz")

vim.keymap.set("n", "<left>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<down>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<up>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<right>", "<cmd>wincmd l<cr>")

vim.keymap.set("n", "<s-left>", "<cmd>wincmd H<cr>")
vim.keymap.set("n", "<s-down>", "<cmd>wincmd J<cr>")
vim.keymap.set("n", "<s-up>", "<cmd>wincmd K<cr>")
vim.keymap.set("n", "<s-right>", "<cmd>wincmd L<cr>")

-- telescope
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
		},
	},
})

vim.keymap.set("n", "<space>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<space>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<space>j", "<cmd>Telescope jumplist<cr>")
vim.keymap.set("n", "<space>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<space>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<space>gs", "<cmd>Telescope git_stash<cr>")
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
vim.keymap.set("n", "gb", "<cmd>Git blame<cr>")
vim.keymap.set("n", "gB", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "?", "<cmd>Git<cr><cmd>wincmd L<cr>")
vim.keymap.set("n", "<space><space>", "<cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit!<cr>")
vim.keymap.set("n", "<space>s", "<cmd>Gitsigns stage_hunk<cr>")

-- lsp
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

vim.keymap.set("n", "gpd", function()
	goto_preview.goto_preview_definition()
end)
vim.keymap.set("n", "gpy", function()
	goto_preview.goto_preview_type_definition()
end)
vim.keymap.set("n", "gpr", function()
	goto_preview.goto_preview_references()
end)
vim.keymap.set("n", "gpi", function()
	goto_preview.goto_preview_implementation()
end)

-- tabs
vim.keymap.set("n", "<c-t>", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<c-h>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>tabnext<cr>")

-- folds (ufo)
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
vim.keymap.set("n", "zm", ufo.closeFoldsWith)
vim.keymap.set("n", "K", function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)

log_time("keymaps")

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
vim.opt.shell = "fish"
vim.opt.laststatus = 3
vim.opt.conceallevel = 2

log_time("startupcommands")

-- colorscheme
require("kanagawa").setup({
	overrides = function(_)
		return {
			LspInlayHint = { link = "Comment" },

			LineNrAbove = { fg = "#625e5a", bg = "#282727" },
			LineNrBelow = { fg = "#625e5a", bg = "#282727" },

			["@markup.heading.1.markdown"] = { fg = "#8992a5" },
			["@markup.heading.2.markdown"] = { fg = "#8992a5" },
			["@markup.heading.3.markdown"] = { fg = "#8992a5" },
			["@markup.heading.4.markdown"] = { fg = "#8992a5" },
			["@markup.heading.5.markdown"] = { fg = "#8992a5" },
			["@markup.heading.6.markdown"] = { fg = "#8992a5" },

			["@markup.heading.1.marker.markdown"] = { fg = "#8992a5" },
			["@markup.heading.2.marker.markdown"] = { fg = "#8992a5" },
			["@markup.heading.3.marker.markdown"] = { fg = "#8992a5" },
			["@markup.heading.4.marker.markdown"] = { fg = "#8992a5" },
			["@markup.heading.5.marker.markdown"] = { fg = "#8992a5" },
			["@markup.heading.6.marker.markdown"] = { fg = "#8992a5" },

			["@markup.strong.markdown_inline"] = { bold = true },
			["@markup.italic.markdown_inline"] = { italic = true },
		}
	end,
})
vim.cmd.colorscheme("kanagawa-dragon")

log_time("colors")

-- modicator replacement
local function on_mode_enter(mode, color, run_init)
	local cmd = string.format("hi LineNr guifg=#%x", color)
	vim.api.nvim_create_autocmd({ "ModeChanged" }, {
		pattern = { "*:[" .. mode .. "]*" },
		command = cmd,
	})
	if run_init then
		vim.cmd(cmd)
	end
end

on_mode_enter("n", vim.api.nvim_get_hl(0, { name = "lualine_a_normal" }).bg, true)
on_mode_enter("i", vim.api.nvim_get_hl(0, { name = "lualine_a_insert" }).bg, false)
on_mode_enter("vV\x16", vim.api.nvim_get_hl(0, { name = "lualine_a_visual" }).bg, false)
on_mode_enter(":", vim.api.nvim_get_hl(0, { name = "lualine_a_command" }).bg, false)
on_mode_enter("r", vim.api.nvim_get_hl(0, { name = "lualine_a_replace" }).bg, false)

-- configure neovide, if enabled
if vim.g.neovide then
	local default_scale_factor = 1.0

	vim.g.neovide_scale_factor = default_scale_factor

	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_refresh_rate = 144

	vim.g.neovide_fullscreen = true

	vim.keymap.set("n", "<c-=>", function()
		if vim.g.neovide_scale_factor < 3 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
			vim.cmd('lua print("Resized window.")')
		end
	end)

	vim.keymap.set("n", "<c-->", function()
		if vim.g.neovide_scale_factor > 0.5 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
			vim.cmd('lua print("Resized window.")')
		end
	end)

	vim.keymap.set("n", "<c-0>", function()
		vim.g.neovide_scale_factor = default_scale_factor
		vim.cmd('lua print("Resized window.")')
	end)
end

log_time("neovide")

for _, name in pairs(time_names) do
	-- vim.cmd("let " .. name)
end
