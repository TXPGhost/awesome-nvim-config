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
			lspconfig.denols.setup({ capabilities = capabilities })
			lspconfig.gdscript.setup({ capabilities = capabilities })

			vim.fn.sign_define("DiagnosticSignError", { text = "" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "" })
			vim.fn.sign_define("DiagnosticSignOk", { text = "" })

			vim.diagnostic.config({ severity_sort = true, virtual_text = false })
			-- vim.diagnostic.config({ severity_sort = true, virtual_text = { prefix = "" } })

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

			-- hover
			vim.keymap.set("n", "K", function()
				local winid = require('ufo').peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)

			-- LSP settings (for overriding per client)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

			vim.keymap.set("n", "<space>d", "<cmd>Telescope diagnostics<cr>")
			vim.keymap.set("n", "<space>a", function() vim.lsp.buf.code_action() end)

			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

			vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>")
			vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>")
			vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
			vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")
			vim.keymap.set("n", "gs", "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>")
			vim.keymap.set("n", "<space>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)

			-- switch source/header
			vim.keymap.set("n", "<space>s", "<cmd>ClangdSwitchSourceHeader<cr>")

			-- navigate soft line wraps
			vim.keymap.set("n", "j", "gj")
			vim.keymap.set("n", "k", "gk")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"mfussenegger/nvim-jdtls",
		event = "VeryLazy",
		config = function()
			local config = {
				cmd = { "/usr/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "build.gradle", "gradlew", ".git", "mvnw" },
						{ upward = true })
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
							-- snippetTextEdit = false
						},
						textDocument = {
							completion = {
								completionItem = {
									-- snippetSupport = false
								}
							}
						}
					},
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true
							},
						}
					},
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
			local large_file_disable = function(buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(_, buf)
						return large_file_disable(buf)
					end,
				},
				indent = {
					enable = true
				},
				endwise = {
					enable = true,
				},
			})
			-- require("treesitter-context").setup({
			-- 	on_attach = function(buf)
			-- 		return large_file_disable(buf)
			-- 	end,
			-- })
			require('nvim-ts-autotag').setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false
				},
			})
		end,
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
			-- "nvim-treesitter/nvim-treesitter-context",
		},
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
				jsonc = { "deno_fmt" },
				typescript = { "deno_fmt" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				vue = { "prettier" },
				markdown = { "prettier" },
				yaml = { "deno_fmt" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				haskell = { "ormolu" },
				python = { "black", "isort" },
				latex = { "latexindent" },
				tex = { "latexindent" },
				_ = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				if not vim.api.nvim_buf_get_option(bufnr, "modified") then
					return
				end
				return { timeout_ms = 10000, lsp_fallback = true }
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
			local snippy = require("snippy")

			require("copilot_cmp").setup()

			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and
					vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
					nil
			end

			local fast_cmp_visible = function()
				if not (cmp.core.view and cmp.core.view.custom_entries_view) then
					return false
				end
				return cmp.core.view.custom_entries_view:visible()
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						snippy.expand_snippet(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				matching = {
					disallow_fuzzy_matching = true,
					disallow_fullfuzzy_matching = true,
					disallow_partial_fuzzy_matching = true,
					disallow_partial_matching = true,
					disallow_prefix_unmatching = false,
				},
				mapping = cmp.mapping.preset.insert({
					["<cr>"] = cmp.mapping(function(fallback)
						local entry = cmp.core.view:get_selected_entry()
						if fast_cmp_visible() and not (entry and entry.source.name == "nvim_lsp_signature_help") then
							cmp.confirm({ select = true })
							cmp.close()
						elseif snippy.can_expand_or_advance() then
							snippy.expand_or_advance()
						else
							-- expand tags on enter
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local line_text = vim.api.nvim_get_current_line()
							if col > 0 and col < #line_text then
								if line_text:sub(col, col) == '>' and line_text:sub(col + 1, col + 1) == '<' then
									vim.api.nvim_feedkeys(
										vim.api.nvim_replace_termcodes(
											"<cr><esc>O", true, true, true),
										'n',
										true)
									return
								end
							end

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
					end, { "i", "s" })
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
				}, {}),
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
						ellipsis_char = '...',
						show_labelDetails = true,
					})
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
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"dcampos/nvim-snippy",
			"zbirenbaum/copilot-cmp",
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
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("ultimate-autopair").setup({
				internal_pairs = { -- *ultimate-autopair-pairs-default-pairs*
					{ '[', ']', fly = true,     dosuround = true, newline = true, space = true },
					{ '(', ')', fly = true,     dosuround = true, newline = true, space = true },
					{ '{', '}', fly = true,     dosuround = true, newline = true, space = true },
					{ '"', '"', suround = true, multiline = false },
					{
						"'",
						"'",
						suround = true,
						cond = function(fn)
							return not
								fn.in_lisp() or fn.in_string()
						end,
						alpha = true,
						nft = { 'tex' },
						multiline = false
					},
					{
						'`',
						'`',
						cond = function(fn)
							return not fn.in_lisp() or
								fn.in_string()
						end,
						nft = { 'tex' },
						multiline = false
					},
					{ '``',                 "''",               ft = { 'tex' } },
					{ '```',                '```',              newline = true,              ft = { 'markdown' } },
					{ '<!--',               '-->',              ft = { 'markdown', 'html' }, space = true },
					{ '"""',                '"""',              newline = true,              ft = { 'python' } },
					{ "'''",                "'''",              newline = true,              ft = { 'python' } },
					{ '$',                  '$',                ft = { 'tex', 'markdown' },  multiline = false },
					{ '$$',                 '$$',               ft = { 'tex', 'markdown' },  multiline = true },
					{ '\\begin{align}',     '\\end{align}',     ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{align*}',    '\\end{align*}',    ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{enumerate}', '\\end{enumerate}', ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{pmatrix}',   '\\end{pmatrix}',   ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{bmatrix}',   '\\end{bmatrix}',   ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{vmatrix}',   '\\end{vmatrix}',   ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{tabular}',   '\\end{tabular}',   ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{center}',    '\\end{center}',    ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{itemize}',   '\\end{itemize}',   ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{document}',  '\\end{document}',  ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
					{ '\\begin{split}',     '\\end{split}',     ft = { 'tex', 'markdown' },  multiline = true,   newline = true },
				}
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add    = { text = '│' },
					change = { text = '│' },
				},
				signs_staged = {
					add    = { text = '│' },
					change = { text = '│' },
				},
			})

			vim.keymap.set("n", "<space><space>", "<cmd>Gitsigns preview_hunk<cr>")
			vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>zz")
			vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>zz")
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
			vim.keymap.set("n", "<space>g", "<cmd>Git<cr><cmd>wincmd L<cr>")
			vim.keymap.set("n", "<space>G",
				"<cmd>Gvdiffsplit!<cr><cmd>set foldcolumn=0<cr><cmd>wincmd h<cr><cmd>set foldcolumn=0<cr>")
			vim.keymap.set("n", "<space>b", "<cmd>Gitsigns blame<cr>")
		end,
	},
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
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
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/",
							"file")
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
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = { enabled = false },
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("ibl").setup({
				indent = { char = "▏" },
				scope = { enabled = false },
			})
		end
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		event = "VeryLazy",
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "main",
					path = "~/vaults",
				}
			},
			completion = {
				min_chars = 1,
				wiki_link_func = function(opts)
					return string.format("[[%s]]", opts.path)
				end,
			},
			ui = {
				enable = false,
				-- checkboxes = {
				-- 	[" "] = { char = "", hl_group = "ObsidianTodo" },
				-- 	["x"] = { char = "", hl_group = "ObsidianDone" },
				-- },
				-- hl_groups = {},
			},
			mappings = {
				["gd"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<space><space>"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
			follow_url_func = function(url)
				vim.fn.jobstart({ "xdg-open", url })
			end,
			note_id_func = function(title)
				return title
			end,
			disable_frontmatter = true,
		}
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 500,
				providers = {
					"lsp",
					"treesitter",
				}
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					window = {
						mappings = {
							["O"] = "system_open",
							["/"] = "noop",
							["esc"] = "noop",
						},
					},
				},
				commands = {
					system_open = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.jobstart({ "xdg-open", path }, { detach = true })
					end,
				},
			})
		end
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				highlights = {
					["Normal"] = { link = "NeoTreeNormal" },
				},
				shade_terminals = false,
				insert_mappings = false,
				start_in_insert = false,
			})
		end
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			auto_close = true,
			auto_jump = true,
			warn_no_results = false,
			win = {
				size = 0.2,
			},
			throttle = {
				refresh = 0,
				update = 0,
				render = 0,
				follow = 0,
				preview = { ms = 0, debounce = false },
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		config = function()
			require("ufo").setup({
				open_fold_hl_timeout = 0,
				close_fold_kinds_for_ft = { default = { "imports", "comment" } },
				preview = {
					win_config = {
						winhighlight = "Pmenu:Pmenu",
						winblend = 0,
					},
				},
			})
		end
	},
	{
		"nanotee/zoxide.vim",
		cmd = "Z",
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
	vim.cmd("e " .. debug.getinfo(1).source:sub(2))
end, {})

-- disable auto comment
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions=qnlj")

-- keymaps
do
	-- easy enter terminal mode
	vim.keymap.set(
		"n",
		"<cr>",
		"<cmd>ToggleTerm<cr>"
	)

	-- easy exit terminal mode
	vim.keymap.set("t", "<c-a>", "<c-\\><c-n>")

	-- navigation
	vim.keymap.set("n", "<c-h>", "<c-w><c-h>")
	vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
	vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
	vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
	vim.keymap.set("n", "<c-t>", "<cmd>tabnew<cr>")
	vim.keymap.set("n", "L", "<cmd>tabnext<cr>")
	vim.keymap.set("n", "H", "<cmd>tabprev<cr>")
	vim.keymap.set("n", "<c-s>", function()
		-- local width = vim.api.nvim_win_get_width(0)
		-- local height = vim.api.nvim_win_get_height(0)
		-- if width >= height * 2.167 then
		vim.cmd("wincmd v")
		vim.cmd("wincmd l")
		-- else
		-- vim.cmd("wincmd s")
		-- vim.cmd("wincmd j")
		-- end
	end)
	vim.keymap.set("n", "<a-h>", "<c-w><c-<>")
	vim.keymap.set("n", "<a-j>", "<c-w><c-+>")
	vim.keymap.set("n", "<a-k>", "<c-w><c-->")
	vim.keymap.set("n", "<a-l>", "<c-w><c->>")

	-- clear highlighting
	vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

	-- obsidian
	vim.keymap.set("n", "<space>n", "<cmd>ObsidianSearch<cr>")

	-- file tree
	vim.keymap.set("n", "-", "<cmd>Neotree toggle<cr>")
	vim.keymap.set("n", "`", "<cmd>Neotree buffers toggle<cr>")
	vim.keymap.set("n", "<space>-", "<cmd>Neotree reveal_force_cwd<cr>")
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
vim.opt.pumheight = 20
vim.opt.termguicolors = true
vim.opt.mousescroll = "hor:1,ver:1"
vim.opt.conceallevel = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

-- colorscheme
vim.cmd.colorscheme("new")

-- neovide config
if vim.g.neovide then
	local default_scale_factor = 1

	vim.opt.guifont = "NotoMono Nerd Font Mono:h9"
	vim.opt.linespace = -1

	vim.g.neovide_scale_factor = default_scale_factor

	vim.keymap.set("n", "<c-=>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
		vim.cmd("redraw!")
	end)
	vim.keymap.set("n", "<c-->", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
		vim.cmd("redraw!")
	end)
	vim.keymap.set("n", "<c-0>", function()
		vim.g.neovide_scale_factor = default_scale_factor
		vim.cmd("redraw!")
	end)
end
