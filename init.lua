local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "kevinhwang91/promise-async", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		config = function()
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
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		priority = 1000,
		opts = {
			transparent_background = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				identifiers = { italic = false },
				functions = { italic = false },
				variables = { italic = false },
			},
			custom_highlights = function(_, palette)
				return {
					["LineNr"] = { fg = palette.fg },
					["LineNrAbove"] = { fg = palette.bg4 },
					["LineNrBelow"] = { fg = palette.bg4 },

					["@conceal.markdown_inline"] = { fg = palette.bg3 },
					["@markup.raw.delimiter.markdown"] = { fg = palette.bg3 },
					["@markup.raw.block.markdown"] = { fg = palette.green },

					["@markup.heading.markdown"] = { fg = palette.blue },

					["@markup.quote.markdown"] = { fg = palette.yellow, italic = true },

					["@markup.heading.1.markdown"] = { fg = palette.blue, underline = true, bold = true },
					["@markup.heading.2.markdown"] = { fg = palette.blue, underline = true, bold = true },
					["@markup.heading.3.markdown"] = { fg = palette.blue, underline = true, bold = true },
					["@markup.heading.4.markdown"] = { fg = palette.blue, underline = true, bold = true },
					["@markup.heading.5.markdown"] = { fg = palette.blue, underline = true, bold = true },
					["@markup.heading.6.markdown"] = { fg = palette.blue, underline = true, bold = true },

					["@markup.link.label.markdown_inline"] = { fg = palette.blue, underline = true },
					["@markup.link.url.markdown_inline"] = { fg = palette.cyan },

					["@markup.list.markdown"] = { fg = palette.purple, bold = true },

					["@markup.heading.1.marker.markdown"] = { fg = palette.bg3 },
					["@markup.heading.2.marker.markdown"] = { fg = palette.bg3 },
					["@markup.heading.3.marker.markdown"] = { fg = palette.bg3 },
					["@markup.heading.4.marker.markdown"] = { fg = palette.bg3 },
					["@markup.heading.5.marker.markdown"] = { fg = palette.bg3 },
					["@markup.heading.6.marker.markdown"] = { fg = palette.bg3 },

					["@punctuation.special.markdown"] = { fg = palette.red },

					["@markup.strong.markdown_inline"] = { fg = palette.orange, bold = true },
					["@markup.italic.markdown_inline"] = { fg = palette.orange, italic = true },
					["@markup.strikethrough.markdown_inline"] = { fg = palette.orange, strikethrough = true },
				}
			end,
			terminal_colors = false,
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{ "tpope/vim-commentary", event = "BufRead" },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.vimls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.cmake.setup({ capabilities = capabilities })
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
			lspconfig.wgsl_analyzer.setup({ capabilities = capabilities })
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
			lspconfig.denols.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("package.json"),
			})

			vim.fn.sign_define("DiagnosticSignError", { text = "" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "" })
			vim.fn.sign_define("DiagnosticSignOk", { text = "" })

			vim.diagnostic.config({ severity_sort = true, virtual_text = { prefix = "" } })
		end,
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			vim.g.code_action_menu_show_action_kind = false
			vim.g.code_action_menu_show_details = false
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle", "TroubleClose" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
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
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			local jdtls = require("jdtls")
			local config = {
				cmd = { "/usr/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
				init_options = {
					bundles = {
						vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", 1),
					},
				},
			}
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "java" },
				callback = function()
					require("jdtls").start_or_attach(config)
				end,
			})
		end,
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				dap = {
					adapter = {
						cfg.get_codelldb_adapter("/usr/bin/codelldb"),
					},
				},
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
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		keys = { "<space>r" },
		config = function()
			require("inc_rename").setup({})
			vim.keymap.set("n", "<space>r", ":IncRename ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = function()
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
						node_incremental = "<tab>",
						node_decremental = "<s-tab>",
					},
				},
				indent = {
					enable = true,
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
		end,
		dependencies = { "RRethy/nvim-treesitter-endwise", "windwp/nvim-ts-autotag" },
	},
	{
		"stevearc/oil.nvim",
		keys = { "-" },
		event = "BufRead",
		config = function()
			vim.keymap.set("n", "-", "<cmd>Oil<cr>zz", { desc = "Open parent directory" })
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
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
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
					args = {
						"--doc-comments=before",
						"--wrap-comments",
						"--parse-docstrings",
						"--name",
						"$FILENAME",
						"-",
					},
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = {
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
				},
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "CmdlineEnter",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			lspkind.init({})

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
					["<cr>"] = cmp.mapping(function(fallback)
						if cmp.get_selected_entry() ~= nil then
							cmp.confirm()
							if vim.fn["vsnip#available"](1) == 1 then
								feedkey("<Plug>(vsnip-expand-or-jump)", "")
							end
						else
							fallback()
						end
					end),
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
					{ name = "copilot" },
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
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"zbirenbaum/copilot.lua",
			"zbirenbaum/copilot-cmp",
		},
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
	{ "tpope/vim-surround", event = "VeryLazy" },
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup({ update_debounce = 0 })
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = true,
		keys = { "?" },
		cmd = "Git",
		config = function()
			vim.keymap.set("n", "?", "<cmd>Git<cr><cmd>wincmd L<cr>")
			vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit!<cr>")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		lazy = true,
		config = function()
			local ufo = require("ufo")
			ufo.setup({
				open_fold_hl_timeout = 0,
				close_fold_kinds = { "imports", "comment" },
			})
			vim.keymap.set("n", "zR", ufo.openAllFolds)
			vim.keymap.set("n", "zM", ufo.closeAllFolds)
			vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
			vim.keymap.set("n", "zm", ufo.closeFoldsWith)
			vim.keymap.set("n", "]f", function()
				ufo.goNextClosedFold()
			end)
			vim.keymap.set("n", "[f", function()
				ufo.goPreviousClosedFold()
			end)
			vim.keymap.set("n", "K", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
			vim.opt.foldlevel = 99999
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "tpope/vim-sleuth", event = "BufRead" },
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("MarkdownPreviewOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("MarkdownPreviewClose", require("peek").close, {})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
					gitcommit = true,
					gitrebase = true,
					hgcommit = true,
					svn = true,
					cvs = true,
					["."] = true,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		lazy = true,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{
		"Wansmer/treesj",
		keys = { "<c-j>", "<c-k>" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
			vim.keymap.set("n", "<c-j>", "<cmd>TSJSplit<cr>")
			vim.keymap.set("n", "<c-k>", "<cmd>TSJJoin<cr>")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		keys = { "<space>c", "<space>C" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()

			vim.keymap.set("n", "<space><space>", "<cmd>DapToggleBreakpoint<cr>")
			vim.keymap.set("n", "<up>", "<cmd>DapStepOut<cr>")
			vim.keymap.set("n", "<down>", "<cmd>DapStepOver<cr>")
			vim.keymap.set("n", "<right>", "<cmd>DapStepInto<cr>")
			vim.keymap.set("n", "<space>c", "<cmd>DapContinue<cr>")

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })

			dapui.setup({})
			vim.keymap.set("n", "<space>c", function()
				dapui.open()
				vim.cmd("DapContinue")
			end)
			vim.keymap.set("n", "<space>C", function()
				dapui.close()
			end)

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		dependencies = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui" },
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
	},
})

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

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

-- config quick edit
vim.api.nvim_create_user_command("Config", function()
	vim.cmd("e ~/.config/nvim/init.lua")
end, {})

-- disable auto comment
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions=qnlj")

-- keymaps
do
	local map = vim.keymap.set

	-- use esc key to exit trouble window and kill highlighting
	map("n", "<esc>", "<cmd>noh<cr><cmd>TroubleClose<cr>")

	-- easy enter terminal mode
	map(
		"n",
		"<c-cr>",
		"<cmd>terminal<cr><cmd>setlocal nonumber<cr><cmd>setlocal norelativenumber<cr><cmd>setlocal signcolumn=no<cr>i"
	)

	-- easy exit terminal mode
	map("t", "<c-a>", "<c-\\><c-n>")

	map("n", "<space>f", "<cmd>Telescope fd<cr>")
	map("n", "<space>b", "<cmd>Telescope buffers<cr>")
	map("n", "<space>j", "<cmd>Telescope jumplist<cr>")
	map("n", "<space>gc", "<cmd>Telescope git_commits<cr>")
	map("n", "<space>gb", "<cmd>Telescope git_branches<cr>")
	map("n", "<space>gs", "<cmd>Telescope git_stash<cr>")
	map("n", "<space>/", "<cmd>Telescope live_grep<cr>")

	-- maintain visual selection when changing indent level
	map("v", ">", ">gv")
	map("v", "<", "<gv")

	-- git
	map("n", "]h", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
	map("n", "[h", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
	map("n", "ghs", "<cmd>Gitsigns stage_hunk<cr>")
	map("n", "ghu", "<cmd>Gitsigns undo_stage_hunk<cr>")
	map("n", "ghr", "<cmd>Gitsigns reset_hunk<cr>")

	-- lsp
	map("n", "<space>k", function()
		vim.lsp.buf.hover()
	end)
	map("n", "<space>d", "<cmd>TroubleToggle document_diagnostics<cr>")
	map("n", "<space>D", "<cmd>TroubleToggle workspace_diagnostics<cr>")
	map("n", "<space>a", "<cmd>CodeActionMenu<cr>")

	map("n", "]d", function()
		vim.diagnostic.goto_next()
	end)
	map("n", "[d", function()
		vim.diagnostic.goto_prev()
	end)

	map("n", "gd", function()
		vim.lsp.buf.definition()
	end)
	map("n", "gy", function()
		vim.lsp.buf.type_definition()
	end)
	map("n", "gr", "<cmd>Trouble lsp_references<cr>")
	map("n", "gi", "<cmd>Trouble lsp_implementations<cr>")

	-- tabs
	map("n", "<c-t>", "<cmd>tabnew<cr>")
	map("n", "<c-h>", "<cmd>tabprev<cr>")
	map("n", "<c-l>", "<cmd>tabnext<cr>")
end

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
vim.opt.clipboard = "unnamedplus"
vim.opt.shada = ""
