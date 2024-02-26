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

-- load plugins
do
	-- dependencies
	plug("nvim-lua/plenary.nvim")
	log_time("plug_plenary")

	-- startup time
	plug("dstein64/vim-startuptime")
	log_time("plug_vim_startuptime")

	-- themes
	plug("rebelot/kanagawa.nvim")
	log_time("plug_kanagawa")

	-- lualine
	plug("nvim-lualine/lualine.nvim")
	log_time("plug_lualine")

	-- comment toggling
	plug("tpope/vim-commentary")
	log_time("plug_vim_commentary")

	-- better fold
	plug("kevinhwang91/promise-async")
	log_time("plug_promise_async")

	-- LSP
	plug("neovim/nvim-lspconfig")
	log_time("plug_lspconfig")
	plug("weilbith/nvim-code-action-menu")
	log_time("plug_code_action_menu")
	plug("folke/trouble.nvim")
	log_time("plug_trouble")
	plug("mrcjkb/rustaceanvim")
	log_time("plug_rust")

	-- tree-sitter
	plug("nvim-treesitter/nvim-treesitter")
	log_time("plug_nvim_treesitter")

	-- file explorer
	plug("stevearc/oil.nvim")
	log_time("plug_oil")

	-- formatter
	plug("stevearc/conform.nvim")
	log_time("plug_conform")

	-- telescope
	plug("nvim-telescope/telescope.nvim")
	log_time("plug_telescope")

	-- autocompletion
	plug("hrsh7th/nvim-cmp")
	plug("hrsh7th/cmp-nvim-lsp")
	plug("hrsh7th/cmp-nvim-lsp-signature-help")
	plug("hrsh7th/cmp-nvim-lsp-document-symbol")
	plug("hrsh7th/cmp-vsnip")
	plug("hrsh7th/vim-vsnip")
	plug("hrsh7th/cmp-cmdline")
	plug("onsails/lspkind.nvim")
	log_time("plug_cmp")

	-- auto pairs
	plug("altermo/ultimate-autopair.nvim")
	plug("abecodes/tabout.nvim")
	plug("windwp/nvim-ts-autotag")
	plug("RRethy/nvim-treesitter-endwise")

	-- surround
	plug("tpope/vim-surround")
	log_time("plug_surround")

	-- git integration
	plug("lewis6991/gitsigns.nvim")
	plug("tpope/vim-fugitive")
	log_time("plug_fugitive")

	-- better folds
	plug("kevinhwang91/nvim-ufo")

	-- icons
	plug("nvim-tree/nvim-web-devicons")
	log_time("plug_devicons")

	-- automatic tab type detection
	plug("tpope/vim-sleuth")
	log_time("plug_sleuth")

	-- markdown preview
	plug("cloudsftp/peek.nvim")
	log_time("plug_markdown")
end

---@diagnostic disable-next-line: param-type-mismatch
vim.call("plug#end")

log_time("vimplug")

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

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
		javascript = { "deno_fmt" },
		javascriptreact = { "deno_fmt" },
		json = { "deno_fmt" },
		typescript = { "deno_fmt" },
		html = { "deno_fmt" },
		css = { "deno_fmt" },
		scss = { "deno_fmt" },
		vue = { "deno_fmt" },
		markdown = { "deno_fmt" },
		yaml = { "deno_fmt" },
		rust = { "rustfmt" },
		c = { "clang_format" },
		cpp = { "clang_format" },
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
	},
})

log_time("conform")

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

-- markdown preview
local peek = require("peek")
peek.setup({})
vim.api.nvim_create_user_command("MarkdownPreviewOpen", peek.open, {})
vim.api.nvim_create_user_command("MarkdownPreviewClose", peek.close, {})

log_time("markdown")

-- latex
vim.api.nvim_create_user_command("LatexPreview", function()
	local texpath = vim.fn.expand("%")
	local pdfpath = texpath:gsub("%.%w+$", ".pdf")
	vim.cmd("!okular " .. pdfpath .. " &")
end, {})
vim.api.nvim_create_user_command("LatexCompile", function()
	local texpath = vim.fn.expand("%")
	vim.cmd("!tectonic " .. texpath)
end, {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.tex" },
	command = "LatexCompile",
})

log_time("latex")

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

-- cmp
-- nvim-cmp
local cmp = require("cmp")
local lspkind = require("lspkind")
lspkind.init({})

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
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
				vim.cmd("Tabout")
				-- cmp.complete()
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
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
	}, {}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 10000, -- doesn't work?
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.exact,
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes,
			cmp.config.compare.score,
			cmp.config.compare.locality,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
	}, {}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

log_time("cmp")

-- lsp
local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})
lspconfig.marksman.setup({ capabilities = capabilities })
lspconfig.ocamllsp.setup({ capabilities = capabilities, cmd = { "ocamllsp", "--fallback-read-dot-merlin" } })
lspconfig.texlab.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.taplo.setup({ capabilities = capabilities })
lspconfig.dotls.setup({ capabilities = capabilities })
lspconfig.hls.setup({ capabilities = capabilities })
lspconfig.glslls.setup({ capabilities = capabilities })
lspconfig.pylsp.setup({ capabilities = capabilities })
lspconfig.denols.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})
lspconfig.tsserver.setup({ capabilities = capabilities, root_dir = lspconfig.util.root_pattern("package.json") })

log_time("lspconfig")

-- rustaceanvim
vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				check = {
					overrideCommand = {
						"cargo",
						"clippy",
						"--workspace",
						"--message-format=json",
						"--all-targets",
						"--",
						"-Wclippy::bool_to_int_with_if",
						"-Wclippy::case_sensitive_file_extension_comparisons",
						"-Wclippy::clear_with_drain",
						"-Wclippy::cloned_instead_of_copied",
						"-Wclippy::cognitive_complexity",
						"-Wclippy::collection_is_never_read",
						"-Wclippy::debug_assert_with_mut_call",
						"-Wclippy::deref_by_slicing",
						"-Wclippy::derive_partial_eq_without_eq",
						"-Wclippy::doc_link_with_quotes",
						"-Wclippy::doc_markdown",
						"-Wclippy::empty_line_after_doc_comments",
						"-Wclippy::empty_line_after_outer_attr",
						"-Wclippy::empty_structs_with_brackets",
						"-Wclippy::enum_glob_use",
						"-Wclippy::equitable_if_let",
						"-Wclippy::error_impl_error",
						"-Wclippy::explicit_impl_clone_on_copy",
						"-Wclippy::explicit_deref_methods",
						"-Wclippy::explicit_into_iter",
						"-Wclippy::explicit_iter_loop",
						"-Wclippy::fallible_impl_from",
						"-Wclippy::filter_map_next",
						"-Wclippy::flat_map_option",
						"-Wclippy::format_push_string",
						"-Wclippy::from_iter_instead_of_collect",
						"-Wclippy::future_not_send",
						"-Wclippy::get_unwrap",
						"-Wclippy::if_not_else",
						"-Wclippy::if_then_some_else_none",
						"-Wclippy::ignored_unit_patterns",
						"-Wclippy::implicit_clone",
						"-Wclippy::implied_bounds_in_impls",
						"-Wclippy::inconsistent_struct_constructor",
						"-Wclippy::index_refutable_slice",
						"-Wclippy::inefficient_to_string",
						"-Wclippy::infinite_loop",
						"-Wclippy::into_iter_without_iter",
						"-Wclippy::invalid_upcast_comparisons",
						"-Wclippy::iter_not_returning_iterator",
						"-Wclippy::iter_on_empty_collections",
						"-Wclippy::iter_on_single_items",
						"-Wclippy::iter_with_drain",
						"-Wclippy::iter_without_into_iter",
						"-Wclippy::large_digit_groups",
						"-Wclippy::large_futures",
						"-Wclippy::large_include_file",
						"-Wclippy::large_stack_arrays",
						"-Wclippy::large_stack_frames",
						"-Wclippy::large_types_passed_by_value",
						"-Wclippy::let_underscore_untyped",
						"-Wclippy::macro_use_imports",
						"-Wclippy::manual_assert",
						"-Wclippy::manual_clamp",
						"-Wclippy::manual_instant_elapsed",
						"-Wclippy::manual_let_else",
						"-Wclippy::manual_ok_or",
						"-Wclippy::manual_string_new",
						"-Wclippy::map_err_ignore",
						"-Wclippy::map_unwrap_or",
						"-Wclippy::match_on_vec_items",
						"-Wclippy::match_same_arms",
						"-Wclippy::match_wild_err_arm",
						"-Wclippy::match_wildcard_for_single_variants",
						"-Wclippy::mismatching_type_param_order",
						"-Wclippy::missing_fields_in_debug",
						"-Wclippy::mod_module_files",
						"-Wclippy::mut_mut",
						"-Wclippy::mutex_atomic",
						"-Wclippy::mutex_integer",
						"-Wclippy::needless_bitwise_bool",
						"-Wclippy::needless_collect",
						"-Wclippy::needless_continue",
						"-Wclippy::needless_for_each",
						"-Wclippy::needless_pass_by_ref_mut",
						"-Wclippy::needless_raw_string_hashes",
						"-Wclippy::needless_raw_strings",
						"-Wclippy::negative_feature_names",
						"-Wclippy::no_mangle_with_rust_abi",
						"-Wclippy::non_send_fields_in_send_ty",
						"-Wclippy::nonstandard_macro_braces",
						"-Wclippy::option_option",
						"-Wclippy::or_fun_call",
						"-Wclippy::panic_in_result_fn",
						"-Wclippy::path_buf_push_overwrite",
						"-Wclippy::range_minus_one",
						"-Wclippy::range_plus_one",
						"-Wclippy::rc_buffer",
						"-Wclippy::rc_mutex",
						"-Wclippy::read_zero_byte_vec",
						"-Wclippy::readonly_write_lock",
						"-Wclippy::redundant_clone",
						"-Wclippy::redundant_closure_for_method_calls",
						"-Wclippy::redundant_feature_names",
						"-Wclippy::redundant_pub_crate",
						"-Wclippy::redundant_type_annotations",
						"-Wclippy::ref_binding_to_reference",
						"-Wclippy::ref_option_ref",
						"-Wclippy::ref_patterns",
						"-Wclippy::rest_pat_in_fully_bound_structs",
						"-Wclippy::return_self_not_must_use",
						"-Wclippy::same_functions_in_if_condition",
						"-Wclippy::same_name_method",
						"-Wclippy::semicolon_if_nothing_returned",
						"-Wclippy::semicolon_outside_block",
						"-Wclippy::similar_names",
						"-Wclippy::str_to_string",
						"-Wclippy::string_to_string",
						"-Wclippy::suboptimal_flops",
						"-Wclippy::suspicious_operation_groupings",
						"-Wclippy::suspicious_xor_used_as_pow",
						"-Wclippy::tests_outside_test_module",
						"-Wclippy::trait_duplication_in_bounds",
						"-Wclippy::trivial_regex",
						"-Wclippy::trivially_copy_pass_by_ref",
						"-Wclippy::try_err",
						"-Wclippy::type_repetition_in_bounds",
						"-Wclippy::undocumented_unsafe_bloks",
						"-Wclippy::unnecessary_box_returns",
						"-Wclippy::unnecessary_join",
						"-Wclippy::unnecessary_safety_comment",
						"-Wclippy::unnecessary_safety_doc",
						"-Wclippy::unnecessary_self_imports",
						"-Wclippy::unnecessary_struct_initialization",
						"-Wclippy::unnecessary_wraps",
						"-Wclippy::unneeded_field_pattern",
						"-Wclippy::unnested_or_patterns",
						"-Wclippy::unreadable_literal",
						"-Wclippy::unseparated_literal_suffix",
						"-Wclippy::unused_async",
						"-Wclippy::unused_peekable",
						"-Wclippy::unused_rounding",
						"-Wclippy::unused_self",
						"-Wclippy::unwrap_in_result",
						"-Wclippy::use_self",
						"-Wclippy::useless_let_if_seq",
						"-Wclippy::verbose_bit_mask",
						"-Wclippy::verbose_file_reads",
						"-Wclippy::wildcard_dependencies",
						"-Wclippy::wildcard_imports",
						"-Wclippy::zero_sized_map_values",
					},
				},
			},
		},
	},
}

log_time("rustaceanvim")

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

log_time("trouble")

-- ufo
require("ufo").setup({
	open_fold_hl_timeout = 0,
	close_fold_kinds = { "imports", "comment" },
})
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
vim.keymap.set("n", "]f", require("ufo").goNextClosedFold)
vim.keymap.set("n", "[f", require("ufo").goPreviousClosedFold)
vim.keymap.set("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)

-- code actions
vim.g.code_action_menu_show_action_kind = false
vim.g.code_action_menu_show_details = false

log_time("actions")

-- tree-sitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "tex", "latex" },
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
	},
	endwise = {
		enable = true,
	},
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99999

log_time("treesitter")

-- auto pairs
require("ultimate-autopair").setup({})
require("tabout").setup({
	tabkey = "",
	backwards_tabkey = "",
})

-- telescope
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
		},
	},
})

-- KEYMAPS

-- use esc key to exit trouble window and kill highlighting
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><cmd>TroubleClose<cr>")

-- easy enter terminal mode
vim.keymap.set(
	"n",
	"<c-cr>",
	"<cmd>terminal<cr><cmd>setlocal nonumber<cr><cmd>setlocal norelativenumber<cr><cmd>setlocal signcolumn=no<cr>i"
)

-- easy exit terminal mode
vim.keymap.set("t", "<c-a>", "<c-\\><c-n>")

vim.keymap.set("n", "<space>f", "<cmd>Telescope fd<cr>")
vim.keymap.set("n", "<space>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<space>j", "<cmd>Telescope jumplist<cr>")
vim.keymap.set("n", "<space>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<space>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<space>gs", "<cmd>Telescope git_stash<cr>")
vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>")

-- maintain visual selection when changing indent level
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- git
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "?", "<cmd>Git<cr><cmd>wincmd L<cr>")
vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit!<cr>")
vim.keymap.set("n", "<space><space>", "<cmd>Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "ghs", "<cmd>Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "ghu", "<cmd>Gitsigns undo_stage_hunk<cr>")
vim.keymap.set("n", "ghr", "<cmd>Gitsigns reset_hunk<cr>")

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

vim.keymap.set("n", "<space>r", function()
	vim.lsp.buf.rename()
end)
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", "gy", function()
	vim.lsp.buf.type_definition()
end)
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")

-- tabs
vim.keymap.set("n", "<c-t>", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<c-h>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>tabnext<cr>")

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
vim.opt.shell = "fish"
vim.opt.textwidth = 80
vim.opt.cursorline = false
vim.opt.scrolloff = 5

-- disable auto comment
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions=tqnlj")

log_time("startupcommands")

-- colorscheme
require("kanagawa").setup({
	compile = true,
	overrides = function(colors)
		return {
			LineNr = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg_gutter },
			LineNrAbove = { fg = colors.theme.ui.nontext, bg = colors.theme.ui.bg_gutter },
			LineNrBelow = { fg = colors.theme.ui.nontext, bg = colors.theme.ui.bg_gutter },

			StatusLine = { bg = colors.theme.ui.bg_gutter },

			EndOfBuffer = { link = "NonText" },

			["@markup.heading.1.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.2.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.3.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.4.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.5.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.6.markdown"] = { fg = colors.theme.syn.statement },

			["@markup.heading.1.marker.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.2.marker.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.3.marker.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.4.marker.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.5.marker.markdown"] = { fg = colors.theme.syn.statement },
			["@markup.heading.6.marker.markdown"] = { fg = colors.theme.syn.statement },

			["@markup.strong.markdown_inline"] = { bold = true },
			["@markup.italic.markdown_inline"] = { italic = true },
			["@markup.strikethrough.markdown_inline"] = { strikethrough = true },

			["@markup.raw.markdown_inline"] = { fg = colors.theme.syn.regex },
			["@markup.raw.block.markdown"] = { fg = colors.theme.syn.identifier },

			["@markup.link.label.markdown_inline"] = { fg = colors.theme.syn.fun, underline = true },
			["@markup.link.url.markdown_inline"] = { fg = colors.theme.syn.statement, underline = true },
		}
	end,
})
vim.cmd.colorscheme("kanagawa-dragon")

log_time("colorscheme")

-- for _, name in pairs(time_names) do
-- 	vim.cmd("let " .. name)
-- end
