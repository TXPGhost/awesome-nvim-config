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

local large_file_disable = function(buf)
	local max_filesize = 1024 * 1024 -- 1 MB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

require("lazy").setup({
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "kevinhwang91/promise-async", lazy = true },
	{
		"tpope/vim-commentary",
		keys = "gc",
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
				cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-g++" },
			})
			lspconfig.vimls.setup({ capabilities = capabilities })
			lspconfig.cmake.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = { Lua = { completion = { callSnippet = "Replace" } } },
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
			lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
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
						},
					},
				},
			})
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.gdscript.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
			})
			lspconfig.svls.setup({})
			lspconfig.veridian.setup({})
			lspconfig.verible.setup({})

			-- temporary fix for rust analyzer server cancelation request
			for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
				local default_diagnostic_handler = vim.lsp.handlers[method]
				vim.lsp.handlers[method] = function(err, result, context, config)
					if err ~= nil and err.code == -32802 then
						return
					end
					return default_diagnostic_handler(err, result, context, config)
				end
			end

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

			-- LSP settings (for overriding per client)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

			vim.keymap.set("n", "<space>d", "<cmd>Trouble diagnostics<cr>")
			vim.keymap.set("n", "<space>a", function()
				vim.lsp.buf.code_action()
			end)

			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

			vim.keymap.set("n", "<space>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)

			-- switch source/header
			vim.keymap.set("n", "g<space>", "<cmd>ClangdSwitchSourceHeader<cr>")

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
		ft = "java",
		config = function()
			local config = {
				cmd = { "/usr/bin/jdtls" },
				root_dir = vim.fs.dirname(
					vim.fs.find({ "build.gradle", "gradlew", ".git", "mvnw" }, { upward = true })[1]
				),
				init_options = {
					bundles = { vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", 1) },
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
		"smjonas/inc-rename.nvim",
		keys = "<space>r",
		config = function()
			require("inc_rename").setup({})
			vim.keymap.set("n", "<space>r", ":IncRename ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(_, buf)
						return large_file_disable(buf)
					end,
				},
				endwise = { enable = true },
			})
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
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
				jsonc = { "deno_fmt" },
				typescript = { "deno_fmt" },
				html = { "deno_fmt" },
				css = { "deno_fmt" },
				scss = { "deno_fmt" },
				vue = { "prettierd" },
				markdown = { "deno_fmt" },
				yaml = { "deno_fmt" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				haskell = { "ormolu" },
				python = { "isort", "black" },
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
		lazy = true,
		keys = { "<space>f", "<space>/" },
		cmd = { "Telescope" },
		opts = {
			pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" } } },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<space>f", "<cmd>Telescope fd<cr>")
			vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local snippy = require("snippy")

			-- require("copilot_cmp").setup()

			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
				-- matching = {
				-- 	disallow_fuzzy_matching = true,
				-- 	disallow_fullfuzzy_matching = true,
				-- 	disallow_partial_fuzzy_matching = true,
				-- 	disallow_partial_matching = true,
				-- 	disallow_prefix_unmatching = false,
				-- },
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
							if col > 0 and col <= #line_text then
								local c0 = line_text:sub(col, col)
								local c1 = line_text:sub(col + 1, col + 1)
								if c0 == ">" and c1 == "<" then
									vim.api.nvim_feedkeys(
										vim.api.nvim_replace_termcodes("<cr><esc>O<tab>", true, true, true),
										"n",
										true
									)
									return
									-- elseif c0 == "{" then
									-- 	if c1 == "}" then
									-- 		vim.api.nvim_feedkeys(
									-- 			vim.api.nvim_replace_termcodes(
									-- 				"<cr><esc>O", true, true, true),
									-- 			'n',
									-- 			true)
									-- 		return
									-- 	else
									-- 		vim.api.nvim_feedkeys(
									-- 			vim.api.nvim_replace_termcodes(
									-- 				"<cr>}<esc>O", true, true, true),
									-- 			'n',
									-- 			true)
									-- 		return
									-- 	end
									-- elseif c0 == "[" then
									-- 	if c1 == "]" then
									-- 		vim.api.nvim_feedkeys(
									-- 			vim.api.nvim_replace_termcodes(
									-- 				"<cr><esc>O", true, true, true),
									-- 			'n',
									-- 			true)
									-- 		return
									-- 	else
									-- 		vim.api.nvim_feedkeys(
									-- 			vim.api.nvim_replace_termcodes(
									-- 				"<cr>]<esc>O", true, true, true),
									-- 			'n',
									-- 			true)
									-- 		return
									-- 	end
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
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					-- { name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
				}, {}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
					}),
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
			-- "zbirenbaum/copilot-cmp",
		},
	},
	{
		"kylechui/nvim-surround",
		keys = { "ys", "cs", "ds" },
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")

			npairs.setup({})
			-- npairs.add_rule(rule("$$", "$$", "tex"))
			-- npairs.add_rules({
			-- 	rule("\\start(%w*) $", "")
			-- 		:replace_endpair(function(opts)
			-- 			local beforeText = string.sub(opts.line, 0, opts.col)
			-- 			local _, _, match = beforeText:find("\\start(%w*)")
			-- 			if match and #match > 0 then
			-- 				return " \\stop" .. match
			-- 			end
			-- 			return ''
			-- 		end)
			-- 		:with_move(cond.none())
			-- 		:use_key("<space>")
			-- 		:use_regex(true)
			-- })

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
				},
				signs_staged = {
					add = { text = "│" },
					change = { text = "│" },
				},
			})

			vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk_inline<cr>")
			vim.keymap.set("n", "ghs", "<cmd>Gitsigns stage_hunk<cr>")
			vim.keymap.set("n", "ghu", "<cmd>Gitsigns undo_stage_hunk<cr>")
			vim.keymap.set("n", "ghr", "<cmd>Gitsigns reset_hunk<cr>")
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = true,
		keys = { "<space>g", "<space>G", "<space>b" },
		cmd = { "Git", "Gsplit", "Gvsplit", "Gdiffsplit", "Gvdiffsplit" },
		config = function()
			vim.keymap.set("n", "<space>g", "<cmd>Git<cr><cmd>wincmd L<cr>")
			vim.keymap.set(
				"n",
				"<space>G",
				"<cmd>Gvdiffsplit!<cr><cmd>set foldcolumn=0<cr><cmd>wincmd h<cr><cmd>set foldcolumn=0<cr>"
			)
			vim.keymap.set("n", "<space>b", "<cmd>Gitsigns blame<cr>")
		end,
	},
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	{
		"rmagatti/goto-preview",
		keys = { "gp", "gP" },
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
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.g.mkdp_theme = "light"
			vim.g.mkdp_preview_options = {
				-- disable_sync_scroll = 1,
			}
		end,
	},
	{
		"saecki/crates.nvim",
		event = "BufRead Cargo.toml",
		config = function()
			require("crates").setup()
		end,
	},
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = { enabled = false },
	-- 			suggestion = { enabled = false },
	-- 			filetypes = {
	-- 				tex = false,
	-- 			}
	-- 		})
	-- 	end,
	-- },
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 500,
				providers = {
					"lsp",
					"treesitter",
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = "-",
		cmd = "Neotree",
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
						width = 30,
					},
					default_component_configs = {
						filesystem = {
							bind_to_cwd = true,
							follow_current_file = {
								enabled = true,
							},
						},
						buffers = {
							follow_current_file = {
								enabled = true,
							},
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

			vim.keymap.set("n", "-", "<cmd>Neotree<cr>")
			vim.keymap.set("n", "<space>-", "<cmd>Neotree reveal_force_cwd<cr>")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		keys = "<c-cr>",
		config = function()
			require("toggleterm").setup({
				highlights = {
					["Normal"] = { link = "Terminal" },
					["NormalFloat"] = { link = "Terminal" },
				},
				shade_terminals = false,
				insert_mappings = false,
				terminal_mappings = false,
				start_in_insert = false,
				open_mapping = "<c-cr>",
				direction = "tab",
			})
		end,
	},
	{
		"folke/trouble.nvim",
		event = "LspAttach",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				auto_close = true,
				auto_jump = true,
				focus = true,
				warn_no_results = false,
				multiline = false,
				win = {
					size = 0.3,
				},
				throttle = {
					refresh = 0,
					update = 0,
					render = 0,
					follow = 0,
					preview = { ms = 0, debounce = false },
				},
			})

			vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<cr>")
			vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>")
			vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
			vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")
			vim.keymap.set("n", "go", "<cmd>Trouble lsp_incoming_calls<cr>")
			vim.keymap.set("n", "gs", "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>")
		end,
	},
	{
		"nanotee/zoxide.vim",
		cmd = "Z",
	},
	{
		"ThePrimeagen/harpoon",
		keys = "<space>",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<space>`", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<space><space>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<space>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<space>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<space>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<space>4", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<space>5", function()
				harpoon:list():select(5)
			end)
			vim.keymap.set("n", "<space>6", function()
				harpoon:list():select(6)
			end)
			vim.keymap.set("n", "<space>7", function()
				harpoon:list():select(7)
			end)
			vim.keymap.set("n", "<space>8", function()
				harpoon:list():select(8)
			end)
			vim.keymap.set("n", "<space>9", function()
				harpoon:list():select(9)
			end)
		end,
	},
	{
		"Wansmer/treesj",
		keys = { "<space>j", "<space>k" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ use_default_keymaps = false })

			vim.keymap.set("n", "<space>j", require("treesj").split)
			vim.keymap.set("n", "<space>k", require("treesj").join)
		end,
	},
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
	vim.cmd('silent !tmux new -d "tectonic -Z continue-on-errors ' .. texpath .. '"')
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
		vim.cmd("wincmd v")
		vim.cmd("wincmd l")
	end)
	vim.keymap.set("n", "<c-n>", function()
		vim.cmd("new")
		vim.cmd("wincmd L")
	end)
	vim.keymap.set("n", "<a-h>", "<c-w><c-<>")
	vim.keymap.set("n", "<a-j>", "<c-w><c-+>")
	vim.keymap.set("n", "<a-k>", "<c-w><c-->")
	vim.keymap.set("n", "<a-l>", "<c-w><c->>")

	-- clear highlighting
	vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")
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
vim.opt.shortmess:append("I")
-- vim.opt.pumheight = 10
vim.opt.termguicolors = true
vim.opt.mousescroll = "hor:0,ver:2"
vim.opt.conceallevel = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.guifont = "CommitMono:h9.5"

-- spell for markdown files
-- Set spell check only for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- colorscheme
vim.cmd.colorscheme("alac")

-- neovide config
if vim.g.neovide then
	local default_scale_factor = 1

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
