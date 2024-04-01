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
	{ "nvim-lua/plenary.nvim",      lazy = true },
	{ "kevinhwang91/promise-async", lazy = true },
	{
		"tpope/vim-commentary",
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			local ufo = require("ufo")

			vim.opt.foldlevel = 99999

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

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

			-- vim.diagnostic.config({ severity_sort = true, virtual_text = { prefix = "" } })
			vim.diagnostic.config({ severity_sort = true, virtual_text = false })

			-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
			-- 	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 		virtual_text = false,
			-- 	})

			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			-- LSP settings (for overriding per client)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

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
			vim.keymap.set("n", "<space>k", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)

			vim.keymap.set("n", "<space>d", "<cmd>TroubleToggle document_diagnostics<cr>")
			vim.keymap.set("n", "<space>D", "<cmd>TroubleToggle workspace_diagnostics<cr>")
			vim.keymap.set("n", "<space>a", function() vim.lsp.buf.code_action() end)

			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end)
			vim.keymap.set("n", "gy", function()
				vim.lsp.buf.type_definition()
			end)
			vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
			vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")

			ufo.setup({
				open_fold_hl_timeout = 0,
				close_fold_kinds_for_ft = { default = { "imports", "comment" } },
				preview = {
					win_config = {
						winhighlight = "Pmenu:Pmenu",
						winblend = 0,
					},
					mappings = {
						switch = "<space>k"
					}
				},
			})
		end,
		dependencies = { "kevinhwang91/nvim-ufo" }
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
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
		event = "VeryLazy",
		config = function()
			local config = {
				cmd = { "/usr/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "build.gradle", "gradlew", ".git", "mvnw" }, { upward = true })
					[1]),
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
	},
	{
		"mrcjkb/rustaceanvim",
		event = "VeryLazy",
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = {
						experimental = {
							snippetTextEdit = false
						}
					}
				}
			}
		end
	},
	{
		"smjonas/inc-rename.nvim",
		event = "VeryLazy",
		config = function()
			require("inc_rename").setup({})
			vim.keymap.set("n", "<space>r", ":IncRename ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function()
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
						node_incremental = "<tab>",
						node_decremental = "<s-tab>",
					},
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
				indent = {
					enable = true,
				}
			})
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99999
		end,
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
	},
	{
		"Wansmer/treesj",
		event = "VeryLazy",
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
		"stevearc/oil.nvim",
		keys = { "-" },
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "-", "<cmd>Oil<cr>zz", { desc = "Open parent directory" })
			require("oil").setup({
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
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
		event = "VeryLazy",
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
		event = "VeryLazy",
		opts = {
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" },
				},
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<space>f", "<cmd>Telescope fd<cr>")
			vim.keymap.set("n", "<space>b", "<cmd>Telescope buffers<cr>")
			vim.keymap.set("n", "<space>j", "<cmd>Telescope jumplist<cr>")
			vim.keymap.set("n", "<space>g", "<cmd>Telescope git_branches<cr>")
			vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>")
		end
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local should_expand = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				local current_char = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
				return col ~= 0 and current_char ~= "{" and current_char ~= "(" and current_char ~= "["
			end

			local item_kind = {
				Text = 1,
				Method = 2,
				Function = 3,
				Constructor = 4,
				Field = 5,
				Variable = 6,
				Class = 7,
				Interface = 8,
				Module = 9,
				Property = 10,
				Unit = 11,
				Value = 12,
				Enum = 13,
				Keyword = 14,
				Snippet = 15,
				Color = 16,
				File = 17,
				Reference = 18,
				Folder = 19,
				EnumMember = 20,
				Constant = 21,
				Struct = 22,
				Event = 23,
				Operator = 24,
				TypeParameter = 25,
			}

			local item_kind_rankings = {
				[item_kind.Field] = 0,
				[item_kind.Property] = 1,
				[item_kind.Method] = 2,
				[item_kind.Function] = 3,
				[item_kind.Constructor] = 4,
				[item_kind.Keyword] = 5,
				[item_kind.TypeParameter] = 6,
				[item_kind.Variable] = 7,
				[item_kind.Class] = 8,
				[item_kind.Interface] = 9,
				[item_kind.Struct] = 10,
				[item_kind.Enum] = 11,
				[item_kind.EnumMember] = 12,
				[item_kind.Value] = 13,
				[item_kind.Unit] = 14,
				[item_kind.Module] = 15,
				[item_kind.Constant] = 16,
				[item_kind.Snippet] = 17,
				[item_kind.Color] = 18,
				[item_kind.File] = 19,
				[item_kind.Reference] = 20,
				[item_kind.Folder] = 21,
				[item_kind.Event] = 22,
				[item_kind.Operator] = 23,
				[item_kind.Text] = 24,
			}

			local kind_comparator = function(entry1, entry2)
				local kind1 = entry1:get_kind()
				local kind2 = entry2:get_kind()
				if kind1 ~= kind2 then
					local diff = item_kind_rankings[kind1] - item_kind_rankings[kind2]
					if diff < 0 then
						return true
					elseif diff > 0 then
						return false
					end
				end
				return nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				experimental = {
					ghost_text = true,
				},
				completion = {
					completeopt = 'menu,menuone,noinsert'
				},
				mapping = cmp.mapping.preset.insert({
					["<a-]>"] = cmp.mapping.abort(),
					["<a-[>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping(function(fallback)
						if cmp.get_selected_entry() ~= nil then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
						elseif should_expand() and luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end),
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<s-tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				}, {}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 80,
						ellipsis_char = "…",
					}),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.exact,
						cmp.config.compare.offset,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						kind_comparator,
						require("cmp-under-comparator").under,
						cmp.config.compare.length,
						cmp.config.compare.sort_text,
						cmp.config.compare.order,
					},
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline_history" },
					{ name = "cmdline" },
				}, {}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-cmdline",
			"dmitmel/cmp-cmdline-history",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-under-comparator",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp"
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = "VeryLazy",
		opts = {
			fastwarp = {
				map = "<a-0>",
				rmap = "<a-9>",
				cmap = "<a-0>",
				rcmap = "<a-9>",
			}
		},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({ update_debounce = 0 })

			vim.keymap.set("n", "<space><space>", "<cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "ghs", "<cmd>Gitsigns stage_hunk<cr>")
			vim.keymap.set("n", "ghu", "<cmd>Gitsigns undo_stage_hunk<cr>")
			vim.keymap.set("n", "ghr", "<cmd>Gitsigns reset_hunk<cr>")
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = true,
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "?", "<cmd>Git<cr><cmd>wincmd L<cr>")
			vim.keymap.set("n", "g?", "<cmd>Gvdiffsplit!<cr>")
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "tpope/vim-sleuth",            event = "VeryLazy" },
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"echasnovski/mini.move",
		event = "VeryLazy",
		opts = {
			mappings = {
				left = "<",
				right = ">",
				down = ",",
				up = ".",
				line_left = "<m-h>",
				line_right = "<m-l>",
				line_down = "<m-j>",
				line_up = "<m-k>",
			},

			options = {
				reindent_linewise = true,
			},
		},
		config = function(_, opts)
			require("mini.move").setup(opts)
		end,
	},
	{
		"rmagatti/goto-preview",
		event = "VeryLazy",
		config = function()
			local goto_preview = require("goto-preview")
			goto_preview.setup({})

			vim.keymap.set("n", "gpd", goto_preview.goto_preview_definition)
			vim.keymap.set("n", "gpr", goto_preview.goto_preview_references)
			vim.keymap.set("n", "gpi", goto_preview.goto_preview_implementation)
			vim.keymap.set("n", "gpy", goto_preview.goto_preview_type_definition)
			vim.keymap.set("n", "gP", goto_preview.close_all_win)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
		config = function()
			require("lsp-progress").setup({
				client_format = function(client_name, spinner, series_messages)
					return #series_messages > 0
						and ("[" .. client_name .. "] " .. spinner)
						or nil
				end,
			})
			require("lualine").setup({
				sections = {
					lualine_x = { require("lsp-progress").progress, 'encoding', 'fileformat', 'filetype' },
				}
			})

			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "deep",
				transparent = true,
				colors = {
					["bg1"] = "#1c1f26",
					["bg2"] = "#262933",
					["bg3"] = "#2f343f",
				},
				highlights = {
					["@markup.math.latex"] = { fg = "$yellow" },
				}
			})
			require("onedark").load()
		end
	},
	{
		"saecki/crates.nvim",
		event = "BufRead Cargo.toml",
		config = function()
			require("crates").setup()
		end,
	}
})

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

-- latex
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
vim.opt.foldlevel = 99999
vim.opt.shortmess:append("I")
