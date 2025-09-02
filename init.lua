-- make things faster
vim.loader.enable()

-- install lazy plugin manager
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

-- disable some plugins for large files
local large_file_disable = function(buf)
	local max_filesize = 1024 * 1024 -- 1 MiB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
	return false
end

-- returns true if the text before the cursor is only whitespace
local only_whitespace = function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	if col == 0 then
		return false
	end
	local line = vim.api.nvim_get_current_line()
	return line:sub(0, col):match("%S") ~= nil
end

-- plugin definitions
local plugins = {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "kevinhwang91/promise-async", lazy = true },
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lspconfig.marksman.setup({ capabilities = capabilities })
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
			lspconfig.denols.setup({
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})

			lspconfig.ts_ls.setup({
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})
			lspconfig.gdscript.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
			})
			lspconfig.veridian.setup({ capabilities = capabilities })
			lspconfig.jdtls.setup({ capabilities = capabilities })

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

			vim.diagnostic.config({
				severity_sort = true,
				float = true,
				update_in_insert = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})

			vim.keymap.set("n", "<space>d", "<cmd>Trouble diagnostics<cr>")
			vim.keymap.set("n", "<space>a", function()
				vim.lsp.buf.code_action()
			end)

			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end)

			vim.keymap.set("n", "<space>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)

			-- switch source/header
			vim.keymap.set("n", "g<space>", "<cmd>ClangdSwitchSourceHeader<cr>")
		end,
	},
	{
		"rmagatti/goto-preview",
		keys = { "gpd", "gpr", "gpi", "gpy", "gP" },
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
		"smjonas/inc-rename.nvim",
		keys = "<space>r",
		config = function()
			require("inc_rename").setup({})
			vim.keymap.set("n", "<space>r", ":IncRename ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(_, buf)
						return large_file_disable(buf)
					end,
				},
				endwise = { enable = true },
			})
			require("nvim-ts-autotag").setup()
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
				html = { "prettier" },
				css = { "deno_fmt" },
				scss = { "deno_fmt" },
				vue = { "prettierd" },
				markdown = { "deno_fmt" },
				yaml = { "prettierd" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				haskell = { "ormolu" },
				python = { "isort", "black" },
				tex = { "latexindent_no_log" },
				_ = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				if not vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
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
				["latexindent_no_log"] = {
					command = "latexindent",
					args = { "--logfile=/dev/null" },
					range_args = function(_, ctx)
						return { "--lines", ctx.range.start[1] .. "-" .. ctx.range["end"][1] }
					end,
					stdin = true,
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		keys = { "<space>f", "<space>b", "<space>/", "<space>s", "<space>S" },
		cmd = { "Telescope" },
		opts = {
			pickers = { find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/" } } },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<space>f", "<cmd>Telescope fd<cr>")
			vim.keymap.set("n", "<space>b", "<cmd>Telescope buffers<cr>")
			vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>")
			vim.keymap.set("n", "<space>s", "<cmd>Telescope lsp_document_symbols<cr>")
			vim.keymap.set("n", "<space>S", "<cmd>Telescope lsp_workspace_symbols<cr>")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		lazy = true,
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		dependencies = {
			-- "zbirenbaum/copilot.lua",
			"rafamadriz/friendly-snippets",
			-- {
			-- 	"fang2hou/blink-copilot",
			-- 	opts = {
			-- 		kind_icon = " ",
			-- 		kind_hl = "BlinkCmpKindCopilot",
			-- 	},
			-- },
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<cr>"] = { "accept", "snippet_forward", "fallback" },
				["<tab>"] = {
					function(cmp)
						if only_whitespace() then
							return cmp.show()
						else
							return false
						end
					end,
					"select_next",
					"fallback",
				},
				["<s-tab>"] = {
					"select_prev",
					"fallback",
				},
				["<down>"] = { "select_next", "fallback" },
				["<up>"] = { "select_prev", "fallback" },
				["<c-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = {
				nerd_font_variant = "normal",
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "inherit",
					["<cr>"] = { "accept_and_enter", "fallback" },
				},
				completion = {
					menu = { auto_show = true },
					list = { selection = { preselect = false, auto_insert = false } },
				},
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 0 },
				list = { selection = { preselect = false, auto_insert = false } },
				menu = {
					draw = { columns = { { "label", "kind_icon" } } },
					auto_show = false,
				},
			},
			sources = {
				-- default = { "copilot", "lsp", "path", "snippets" },
				default = { "lsp", "path", "snippets" },
				-- providers = {
				-- 	copilot = {
				-- 		name = "copilot",
				-- 		module = "blink-copilot",
				-- 		async = true,
				-- 	},
				-- },
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
			signature = {
				enabled = true,
				trigger = { enabled = false },
				window = { direction_priority = { "n", "s" } },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
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
			npairs.setup({})

			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- local cmp = require("cmp")
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
				update_debounce = 30,
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
		event = { "VeryLazy" },
		config = function()
			vim.keymap.set("n", "<space>g", function()
				vim.cmd("Trouble lsp_document_symbols close")
				vim.cmd("silent! Git")
				vim.cmd("wincmd L")
				vim.cmd("silent! Git")
			end)
			vim.keymap.set(
				"n",
				"<space>G",
				"<cmd>Gvdiffsplit!<cr><cmd>set foldcolumn=0<cr><cmd>wincmd h<cr><cmd>set foldcolumn=0<cr>"
			)
			vim.keymap.set("n", "<space><space>", "<cmd>Gitsigns blame_line<cr>")
		end,
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
	{
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	{
		"n-crespo/peek.nvim",
		cmd = { "PeekOpen", "PeekClose" },
		keys = "<space>m",
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				theme = "light",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
			vim.keymap.set("n", "<space>m", require("peek").open)
			vim.keymap.set("n", "<space>M", require("peek").close)
		end,
	},
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
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
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		keys = "-",
		cmd = "Oil",
		event = { "VimEnter */*,.*", "BufNew */*,.*" },
		config = function()
			require("oil").setup({
				watch_for_changes = true,
				use_default_keymaps = false,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<cr>"] = "actions.select",
					["<c-s>"] = { "actions.select", opts = { vertical = true } },
					["<c-t>"] = { "actions.select", opts = { tab = true } },
					["<c-p>"] = "actions.preview",
					["<c-c>"] = { "actions.close", mode = "n" },
					["<c-r>"] = "actions.refresh",
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
			})

			vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		event = "LspAttach",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			---@diagnostic disable-next-line: missing-fields
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
				modes = {
					lsp_document_symbols = {
						mode = "lsp_document_symbols",
						auto_close = false,
						focus = false,
						win = { position = "right", relative = "win" },
						filter = {
							-- remove Package since luals uses it for control flow structures
							["not"] = {
								any = {
									{ ft = "lua", kind = "Package" },
									kind = { "Variable", "Module" },
								},
							},
						},
					},
				},
			})

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end)
			vim.keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions<cr>")
			vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>")
			vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations<cr>")
			vim.keymap.set("n", "go", "<cmd>Trouble lsp_incoming_calls<cr>")
			vim.keymap.set("n", "gs", "<cmd>Trouble lsp_document_symbols toggle<cr>")
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
	{
		"dfendr/clipboard-image.nvim",
		cmd = "PasteImg",
	},
	{
		"echasnovski/mini.statusline",
		config = function()
			require("mini.statusline").setup({})
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({ highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() } })
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({})
		end,
	},
	{
		"tonymajestro/smart-scrolloff.nvim",
		event = "VeryLazy",
		opts = {
			scrolloff_percentage = 0.1,
		},
	},
	{
		"olimorris/codecompanion.nvim",
		keys = { "<space>i", "<space>I", "<space>A" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.diff",
			"zbirenbaum/copilot.lua",
			"franco-ruggeri/codecompanion-spinner.nvim",
		},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("codecompanion").setup({
				display = { chat = { window = { width = 0.25 } } },
				extensions = { spinner = {} },
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4",
						},
					},
					inline = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4",
						},
					},
					cmd = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4",
						},
					},
				},
			})
			vim.keymap.set({ "n", "v" }, "<space>i", "<cmd>CodeCompanion<cr>")
			vim.keymap.set({ "n", "v" }, "<space>I", "<cmd>CodeCompanionChat Toggle<cr>")
			vim.keymap.set({ "n", "v" }, "<space>A", "<cmd>CodeCompanionActions<cr>")
		end,
	},
	{
		"echasnovski/mini.diff",
		event = "VeryLazy",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				source = diff.gen_source.none(),
			})
		end,
	},
}

---@diagnostic disable-next-line: missing-fields
require("lazy").setup(plugins, {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"man",
				"osc52",
			},
		},
	},
})

-- set help window to vertical split
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "help" }, command = "wincmd L" })

-- latex auto compilation
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

-- set indentation with command
vim.api.nvim_create_user_command("Indent", function(ctxt)
	vim.opt_local.tabstop = tonumber(ctxt.args)
	vim.opt_local.shiftwidth = tonumber(ctxt.args)
end, { nargs = 1 })

-- misc. keymaps
do
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
	vim.keymap.set("n", "<esc>", function()
		vim.cmd.noh()
		vim.snippet.stop()
	end)
end

-- startup opts
vim.opt.compatible = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.shell = "fish"
vim.opt.termguicolors = true
vim.opt.mousescroll = "hor:1,ver:1"
vim.opt.conceallevel = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.pumheight = 30
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.splitright = true
vim.opt.exrc = true

vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=ro")

-- make sure `.ll` gets recognized as llvm
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.ll" },
	callback = function()
		vim.bo.filetype = "llvm"
	end,
})

-- local options for markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 80
	end,
})

-- colorscheme
vim.cmd.colorscheme("rasmus")

-- commentstring for c/c++
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
