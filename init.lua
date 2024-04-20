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

			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-g++" }
			})
			vim.keymap.set("n", "<tab>", "<cmd>ClangdSwitchSourceHeader<cr>")

			lspconfig.vimls.setup({ capabilities = capabilities })
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
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							black = { enabled = true },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							pylint = { enabled = true, executable = "pylint" },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							pylsp_mypy = { enabled = true },
							jedi_completion = { fuzzy = true },
							pyls_isort = { enabled = true },
						}
					}
				}
			})
			lspconfig.denols.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("package.json"),
			})
			lspconfig.gdscript.setup({ capabilities = capabilities })

			vim.fn.sign_define("DiagnosticSignError", { text = "" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "" })
			vim.fn.sign_define("DiagnosticSignOk", { text = "" })

			vim.diagnostic.config({ severity_sort = true, virtual_text = false })

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

			vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>")
			vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>")
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
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true
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

			require("treesitter-context").setup({})
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldlevel = 99999
		end,
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
		},
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
				python = { "black", "isort" },
				_ = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				if not vim.api.nvim_buf_get_option(bufnr, "modified") then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
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
			vim.keymap.set("n", ";", "<cmd>Telescope lsp_document_symbols<cr>")
		end
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local snippy = require("snippy")

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

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and
					vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

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
						snippy.expand_snippet(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<cr>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
							cmp.close()
						elseif snippy.can_expand_or_advance() then
							snippy.expand_or_advance()
						else
							fallback()
						end
					end),
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<s-tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						elseif snippy.can_jump(-1) then
							snippy.previous()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						end
						fallback()
					end, { "i", "s" }),
				}),
				experimental = {
					ghost_text = true,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
				}, {}),
				formatting = {
					fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "…",
						before = function(_, vim_item)
							local index = 0
							for i = 1, string.len(vim_item.abbr) do
								local char = string.sub(vim_item.abbr, i, i)
								if string.match(char, "[%w/\\\\#]") then
									index = i
									break
								end
							end

							vim_item.abbr = string.sub(vim_item.abbr, index);
							vim_item.menu = ""
							return vim_item
						end
					})
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
					{ name = "cmdline" },
				}, {}),
				preselect = cmp.PreselectMode.None,
				completion = { completeopt = "menu,menuone,noselect" },
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-under-comparator",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"dcampos/nvim-snippy",
		},
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
			vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>zz")
			vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>zz")
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
			vim.keymap.set("n", "g?",
				"<cmd>Gvdiffsplit!<cr><cmd>set foldcolumn=0<cr><cmd>wincmd h<cr><cmd>set foldcolumn=0<cr><cmd>wincmd l<cr>")
		end,
	},
	{
		"NMAC427/guess-indent.nvim",
		event = "VeryLazy",
		config = function()
			vim.opt.tabstop = 4
			vim.opt.shiftwidth = 4
			require('guess-indent').setup({})
		end
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
		config = function()
			vim.g.mkdp_theme = "light"
		end
	},
	{
		"saecki/crates.nvim",
		event = "BufRead Cargo.toml",
		config = function()
			require("crates").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		keys = { "<space>c", "<space>C", "<leader>b", "<space>?<space>" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local breakpoints = require("goto-breakpoints")

			require("nvim-dap-virtual-text").setup()

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					args = function()
						local args = {}
						for arg in string.gmatch(vim.fn.input("Command arguments: "), "%S+") do
							table.insert(args, arg)
						end
						return args
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c

			vim.keymap.set("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<space>?<space>", function()
				dap.set_breakpoint(vim.fn.input("Condition: "))
			end)
			vim.keymap.set("n", "<up>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<left>", function()
				dap.step_back()
			end)
			vim.keymap.set("n", "<right>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<down>", function()
				dap.step_into()
			end)

			vim.keymap.set("n", "]b", breakpoints.next)
			vim.keymap.set("n", "[b", breakpoints.prev)

			vim.fn.sign_define("DapStopped", { linehl = "CursorLine" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "󰅙", texthl = "DiagnosticSignError" })

			dapui.setup({})
			vim.keymap.set("n", "<space>c", function()
				if vim.bo.filetype == "java" then
					require("jdtls.dap").setup_dap_main_class_configs()
				elseif vim.bo.filetype == "rust" then
					vim.cmd("RustLsp debuggables")
					return
				end
				dapui.open()
				vim.cmd("DapContinue")
			end)
			vim.keymap.set("n", "<space>C", function()
				dapui.close()
				dap.terminate()
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
		dependencies = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui", "ofirgall/goto-breakpoints.nvim", "nvim-neotest/nvim-nio" },
	},
	{
		"nanozuki/tabby.nvim",
		event = "VimEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.showtabline = 2

			local theme = {
				fill = "TabLineFill",
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
				title = "Title",
				vim_logo = { fg = "#56A56B", bg = "#1A1A1A" },
				file_logo = { fg = "#76787C", bg = "#1A1A1A" },
			}
			require("tabby.tabline").set(function(line)
				return {
					{
						{ '  ', hl = theme.vim_logo },
						line.sep('', theme.head, theme.fill),
					},
					line.tabs().foreach(function(tab)
						local num_wins = 0
						local icons = {}

						local getwinft = function(win)
							local buf = vim.api.nvim_win_get_buf(win.id)
							local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
							if ft == "" then
								ft = vim.api.nvim_buf_get_option(buf, 'buftype')
							end
							return ft
						end

						local geticon = function(ft)
							local icon, color = require('nvim-web-devicons').get_icon_color(name, ft,
								{ default = true })
							if ft == "oil" then
								icon = ""
								color = "#568FA5"
							elseif ft == "fugitive" or ft == "gitcommit" then
								icon = "󰊢"
								color = "#F15030"
							end

							return icon, color
						end

						line.wins_in_tab(tab.id).foreach(function(win)
							local ft = getwinft(win)
							local icon, color = geticon(ft)

							-- TODO: fix background color
							table.insert(icons, line.sep(icon, { bg = color }, theme.fill))
							num_wins = num_wins + 1
						end)

						local hl = tab.is_current() and theme.current_tab or theme.tab

						local name = tab.name()
						local ft = getwinft(tab.current_win())
						if ft == "oil" then
							name = "Files"
						elseif ft == "fugitive" then
							name = "Git"
						end

						local pos = string.find(name, "%[%d%+%]")
						if pos ~= nil then
							name = string.sub(name, 0, pos - 1)
						end

						local ret = {
							line.sep('', hl, theme.fill),
						}

						for _, icon in pairs(icons) do
							table.insert(ret, icon)
						end

						table.insert(ret, " " .. name)
						table.insert(ret, line.sep('', hl, theme.fill))

						ret.hl = hl
						ret.margin = ' '

						return ret
					end),
					-- line.spacer(),
					-- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					-- 	local extension = vim.fn.fnamemodify(win.buf_name(), ':e')
					-- 	local icon, color = require('nvim-web-devicons').get_icon_color(name, extension,
					-- 		{ default = true })

					-- 	return {
					-- 		line.sep('', theme.win, theme.fill),
					-- 		line.sep(icon, { bg = color }, theme.fill),
					-- 		win.buf_name(),
					-- 		line.sep('', theme.win, theme.fill),
					-- 		hl = theme.win,
					-- 		margin = ' ',
					-- 	}
					-- end),
					-- {
					-- 	line.sep('', theme.tail, theme.fill),
					-- 	{ '  ', hl = theme.file_logo },
					-- },
					hl = theme.fill,
				}
			end)
		end
	},
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
	}
})

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

-- latex
vim.api.nvim_create_user_command("LatexCompile", function()
	local texpath = vim.fn.expand("%")
	vim.cmd("!tectonic -Z continue-on-errors " .. texpath)
end, {})
vim.api.nvim_create_user_command("LatexCompileBackground", function()
	local texpath = vim.fn.expand("%")
	vim.cmd("silent !tmux new -d \"tectonic -Z continue-on-errors " .. texpath .. "\"")
end, {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.tex" },
	command = "LatexCompileBackground",
})

-- config quick edit
vim.api.nvim_create_user_command("Config", function()
	vim.cmd("e ~/.config/nvim/init.lua")
end, {})

-- disable auto comment
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions=qnlj")

-- keymaps
do
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

	-- navigation
	vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>")
	vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>")
	vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>")
	vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>")
	vim.keymap.set("n", "<c-t>", "<cmd>tabnew<cr>")
	vim.keymap.set("n", "L", "<cmd>tabnext<cr>")
	vim.keymap.set("n", "H", "<cmd>tabprev<cr>")
end

-- startup commands
vim.opt.compatible = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.shell = "fish"
vim.opt.textwidth = 80
vim.opt.scrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.foldlevel = 99999
vim.opt.shortmess:append("I")
vim.opt.pumheight = 8
vim.opt.termguicolors = true

-- colorscheme
vim.cmd.colorscheme("arob")
