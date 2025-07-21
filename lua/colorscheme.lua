local M = {}

M.blend = function(hex1, hex2, t)
	local function hexToRgb(hex)
		local r = tonumber(hex:sub(2, 3), 16)
		local g = tonumber(hex:sub(4, 5), 16)
		local b = tonumber(hex:sub(6, 7), 16)
		return r, g, b
	end

	local function rgbToHex(r, g, b)
		return string.format("#%02x%02x%02x", r, g, b)
	end

	local r1, g1, b1 = hexToRgb(hex1)
	local r2, g2, b2 = hexToRgb(hex2)

	local r = math.floor(r1 + (r2 - r1) * t + 0.5)
	local g = math.floor(g1 + (g2 - g1) * t + 0.5)
	local b = math.floor(b1 + (b2 - b1) * t + 0.5)

	return rgbToHex(r, g, b)
end

M.colorscheme = function(colors)
	local blend = M.blend

	local fg = colors.fg
	local bg = colors.bg

	local string = colors.string
	local keyword = colors.keyword
	local constant = colors.constant
	local func = colors.func
	local type = colors.type or blend(string, func, 0.8)
	local member = colors.member or blend(keyword, func, 0.5)

	local green = colors.green or string
	local red = colors.red or constant
	local blue = colors.blue or func
	local orange = colors.orange or constant

	local fgg = colors.fgg or blend(bg, fg, 0.85)
	local fggg = colors.fggg or blend(bg, fg, 0.7)
	local fgggg = colors.fgggg or blend(bg, fg, 0.55)
	local fggggg = colors.fggggg or blend(bg, fg, 0.4)

	local bgg = blend(bg, fg, 0.01)
	local bggg = blend(bg, fg, 0.02)
	local bgggg = blend(bg, fg, 0.03)
	local bggggg = blend(bg, fg, 0.04)
	local bgggggg = blend(bg, fg, 0.05)
	local mg = blend(bg, fg, 0.1)

	vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
	vim.api.nvim_set_hl(0, "Identifier", { fg = constant })
	vim.api.nvim_set_hl(0, "Statement", {})
	vim.api.nvim_set_hl(0, "Function", { fg = func })
	vim.api.nvim_set_hl(0, "Constant", { fg = constant })
	vim.api.nvim_set_hl(0, "SpecialKey", { fg = constant })
	vim.api.nvim_set_hl(0, "Special", {})
	vim.api.nvim_set_hl(0, "Operator", { fg = fgg })
	vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
	vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = bgggg, fg = fggg })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = mg, bold = true })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = bggg })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = bggg, fg = fggggg })
	vim.api.nvim_set_hl(0, "Type", { fg = type, bold = true })
	vim.api.nvim_set_hl(0, "PreProc", { fg = string, bold = true })
	vim.api.nvim_set_hl(0, "String", { fg = string })
	vim.api.nvim_set_hl(0, "Character", { fg = string })
	vim.api.nvim_set_hl(0, "SignColumn", {})
	vim.api.nvim_set_hl(0, "FoldColumn", {})
	vim.api.nvim_set_hl(0, "Directory", { fg = string })
	vim.api.nvim_set_hl(0, "ModeMsg", { fg = member, bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = fgggg })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fggggg })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fggggg })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = fggggg })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = bgg })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fgggg })
	vim.api.nvim_set_hl(0, "MsgArea", { fg = fggg, bg = bg })
	vim.api.nvim_set_hl(0, "WinBar", { fg = fgg, bg = bg, italic = true })
	vim.api.nvim_set_hl(0, "WinBarNC", { fg = fggg, bg = bg, italic = true })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = fgg, bg = bgg })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg, bg = bgg })
	vim.api.nvim_set_hl(0, "TabLine", { bg = bgggg })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = bggg })
	vim.api.nvim_set_hl(0, "TabLineSel", { bg = bgg })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = bggggg, bg = bg })
	vim.api.nvim_set_hl(0, "Visual", { bg = bgggg })
	vim.api.nvim_set_hl(0, "Search", { reverse = true })
	vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bggg })
	vim.api.nvim_set_hl(0, "Title", { fg = red })
	vim.api.nvim_set_hl(0, "MatchParen", { bg = bgggggg })
	vim.api.nvim_set_hl(0, "Error", { fg = red, bg = blend(red, bg, 0.9) })
	vim.api.nvim_set_hl(0, "ErrorMsg", { fg = red, bg = blend(red, bg, 0.9) })
	vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
	vim.api.nvim_set_hl(0, "MoreMsg", { fg = constant, bold = true })
	vim.api.nvim_set_hl(0, "Question", { link = "Function" })
	vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Function" })
	vim.api.nvim_set_hl(0, "Todo", { bg = bgggg, bold = true })

	vim.api.nvim_set_hl(0, "diffAdded", { fg = green, bg = blend(green, bg, 0.9) })
	vim.api.nvim_set_hl(0, "diffChanged", { fg = blue, bg = blend(blue, bg, 0.9) })
	vim.api.nvim_set_hl(0, "diffRemoved", { fg = red, bg = blend(red, bg, 0.9) })
	vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

	vim.api.nvim_set_hl(0, "Added", { link = "diffAdded" })
	vim.api.nvim_set_hl(0, "Changed", { link = "diffChanged" })
	vim.api.nvim_set_hl(0, "Removed", { link = "diffRemoved" })
	vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
	vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
	vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
	vim.api.nvim_set_hl(0, "DiffText", { fg = blue, bg = blend(blue, bg, 0.8) })
	vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
	vim.api.nvim_set_hl(0, "GitSignsChange", { fg = blue })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

	vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
	vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

	vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = blend(green, bg, 0.4) })
	vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = blend(green, bg, 0.7) })
	vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = blend(blue, bg, 0.7) })
	vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = blend(blue, bg, 0.4) })
	vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { fg = keyword })

	vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = fg })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = fg })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = blue })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = orange })
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red })

	vim.api.nvim_set_hl(0, "SpellLocal", { link = "DiagnosticUnderlineInfo" })
	vim.api.nvim_set_hl(0, "SpellRare", { link = "DiagnosticUnderlineHint" })
	vim.api.nvim_set_hl(0, "SpellCap", { link = "DiagnosticUnderlineWarn" })
	vim.api.nvim_set_hl(0, "SpellBad", { link = "DiagnosticUnderlineError" })

	vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = blue, undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = orange, undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = red, undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = fggg })

	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = fg, bg = blend(fg, bg, 0.95), italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = fg, bg = blend(fg, bg, 0.95), italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = blue, bg = blend(blue, bg, 0.95), italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = orange, bg = blend(orange, bg, 0.95), italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = red, bg = blend(red, bg, 0.95), italic = true })

	vim.api.nvim_set_hl(0, "@punctuation", { link = "Operator" })
	vim.api.nvim_set_hl(0, "@punctuation.special", { link = "Operator" })
	vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
	vim.api.nvim_set_hl(0, "@keyword", { fg = keyword, italic = true })
	vim.api.nvim_set_hl(0, "@keyword.modifier", { fg = keyword, italic = true })
	vim.api.nvim_set_hl(0, "@variable", { fg = fg })
	vim.api.nvim_set_hl(0, "@function", { link = "Function" })
	vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })

	vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
	vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
	vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })
	vim.api.nvim_set_hl(0, "@lsp.type.typeparameter", { italic = true })

	vim.api.nvim_set_hl(0, "@variable.member", { fg = member })
	vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
	vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
	vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
	vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

	vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
	vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

	vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

	vim.api.nvim_set_hl(0, "@function.macro", { link = "PreProc" })

	vim.api.nvim_set_hl(0, "@type", { link = "Type" })
	vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
	vim.api.nvim_set_hl(0, "@lsp.type", { link = "Type" })
	vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "Operator" })
	vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@module" })
	vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "@keyword" })
	vim.api.nvim_set_hl(0, "@lsp.type.modifier", { link = "@keyword" })
	vim.api.nvim_set_hl(0, "@lsp.type.annotation", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "@string.escape", { link = "Character" })

	vim.api.nvim_set_hl(0, "@lsp.type.macro.c", {})
	vim.api.nvim_set_hl(0, "@lsp.type.macro.cpp", {})

	vim.api.nvim_set_hl(0, "@lsp.type.attributeBracket", {})
	vim.api.nvim_set_hl(0, "@lsp.type.builtinAttribute", {})
	vim.api.nvim_set_hl(0, "@lsp.type.generic", {})

	vim.api.nvim_set_hl(0, "@markup.heading", { fg = orange, bold = true })
	vim.api.nvim_set_hl(0, "@markup.heading.1", { fg = blend(red, orange, 0), bold = true, underline = true })
	vim.api.nvim_set_hl(0, "@markup.heading.2", { fg = blend(red, orange, 0.2), bold = true, underline = true })
	vim.api.nvim_set_hl(0, "@markup.heading.3", { fg = blend(red, orange, 0.4), bold = true, underline = true })
	vim.api.nvim_set_hl(0, "@markup.heading.4", { fg = blend(red, orange, 0.6), bold = true, underline = true })
	vim.api.nvim_set_hl(0, "@markup.heading.5", { fg = blend(red, orange, 0.8), bold = true, underline = true })
	vim.api.nvim_set_hl(0, "@markup.heading.6", { fg = blend(red, orange, 1), bold = true, underline = true })

	vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = fgggg })
	vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = constant })
	vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = fgggg })

	vim.api.nvim_set_hl(0, "@markup.strong", { bold = true })
	vim.api.nvim_set_hl(0, "@markup.italic", { italic = true })
	vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })
	vim.api.nvim_set_hl(0, "@markup.link", { fg = type, underline = true })
	vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "@punctuation" })
	vim.api.nvim_set_hl(0, "@markup.link.url", { link = "@markup.link" })
	vim.api.nvim_set_hl(0, "@markup.link.label", { fg = type, bold = true })
	vim.api.nvim_set_hl(0, "@markup.raw", { link = "@markup.raw.block.markdown" })

	vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = fggg })
	vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = fgggg })

	vim.api.nvim_set_hl(0, "@markup.strong.latex", { bold = true })
	vim.api.nvim_set_hl(0, "@markup.italic.latex", { italic = true })

	vim.api.nvim_set_hl(0, "@label.vimdoc", { link = "@markup.link.label" })
	vim.api.nvim_set_hl(0, "@string.special.vimdoc", { link = "@markup.raw" })

	vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

	vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
	vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

	vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

	vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = string })

	vim.api.nvim_set_hl(0, "@function.make", { fg = string })
	vim.api.nvim_set_hl(0, "@function.cmake", { fg = string })
	vim.api.nvim_set_hl(0, "@function.latex", { fg = string })

	vim.api.nvim_set_hl(0, "@keyword.import.latex", { fg = constant })
	vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = func })

	vim.api.nvim_set_hl(0, "@punctuation.delimiter.comment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@comment.todo.comment", { link = "Todo" })
	vim.api.nvim_set_hl(0, "@comment.note.comment", { bg = bgggg, bold = true })
	vim.api.nvim_set_hl(0, "@comment.warning.comment", { fg = string, bg = bgggg, bold = true })
	vim.api.nvim_set_hl(0, "@comment.error.comment", { fg = constant, bg = bgggg, bold = true })

	vim.api.nvim_set_hl(0, "@function.call.rust", { fg = fg })
	vim.api.nvim_set_hl(0, "@function.macro.rust", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "@lsp.type.macro.rust", { link = "PreProc" })

	vim.api.nvim_set_hl(0, "@tag.html", { link = "Type" })
	vim.api.nvim_set_hl(0, "@tag.xml", { link = "Type" })

	vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@variable.member" })
	vim.api.nvim_set_hl(0, "@tag.css", { link = "@variable.member" })

	vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })

	vim.api.nvim_set_hl(0, "@lsp.type.bracket", { link = "@punctuation" })

	vim.api.nvim_set_hl(0, "@string.documentation.python", { link = "Comment" })

	vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })

	vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = fggg })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = fgg, underline = true })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { strikethrough = true, fg = fggg })

	vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = fgg })

	vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", { fg = green })

	vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = type })
	vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = type })
	vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = type })
	vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = type })
	vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = type })

	vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = constant })
	vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = keyword })
	vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = fggg })
	vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = member })
	vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = fg })

	vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = func })
	vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = func })

	vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = constant })
	vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = constant })

	vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = bg })
	vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = bg })
	vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { bg = bg })
	vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = bg })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = fg })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = bgggg })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = green })
	vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = red })

	vim.api.nvim_set_hl(0, "TroubleNormal", { link = "NeoTreeNormal" })
	vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NeoTreeNormalNC" })
	vim.api.nvim_set_hl(0, "TroubleIndent", { fg = bgggg })
	vim.api.nvim_set_hl(0, "TroubleIconDirectory", { link = "Directory" })

	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = bggg })

	vim.api.nvim_set_hl(0, "@string.escape", { fg = func })
	vim.api.nvim_set_hl(0, "@character.printf", { fg = func })
	vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier", { fg = string })
	vim.api.nvim_set_hl(0, "@character.special", { fg = fggg })

	vim.api.nvim_set_hl(0, "Terminal", { bg = bg })

	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = fggggg })

	vim.api.nvim_set_hl(0, "MiniStatuslineDevInfo", { fg = fgg, bg = bgggg })
	vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = fgg, bg = bgggg })
	vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = fgg, bg = bgg })

	vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = bg, bg = fg, bold = true })
	vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = bg, bg = fg, bold = true })
	vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = bg, bg = fg, bold = true })
	vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = bg, bg = fg, bold = true })
	vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = bg, bg = fg, bold = true })
	vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = bg, bg = fg, bold = true })

	vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { link = "PmenuSel" })

	vim.api.nvim_set_hl(0, "WinBar", { fg = fgg, bg = bgg, italic = false })
	vim.api.nvim_set_hl(0, "WinBarNC", { fg = fggg, bg = bgg, italic = false })

	vim.api.nvim_set_hl(0, "@constructor.ocaml", { link = "Constant" })

	vim.api.nvim_set_hl(0, "OilChange", { fg = blue })
	vim.api.nvim_set_hl(0, "OilCreate", { fg = green })
	vim.api.nvim_set_hl(0, "OilDelete", { fg = red })
	vim.api.nvim_set_hl(0, "OilMove", { fg = blue })
	vim.api.nvim_set_hl(0, "OilCopy", { fg = green })

	vim.api.nvim_set_hl(0, "manSectionHeading", { link = "@markup.heading" })
	vim.api.nvim_set_hl(0, "manSubHeading", { bold = true, fg = blend(red, orange, 0.5) })
	vim.api.nvim_set_hl(0, "manReference", { link = "@markup.link" })

	vim.api.nvim_set_hl(0, "LazyH1", { fg = blend(red, orange, 0), bold = true })
	vim.api.nvim_set_hl(0, "LazyH2", { fg = blend(red, orange, 0.2), bold = true })
	vim.api.nvim_set_hl(0, "LazyH3", { fg = blend(red, orange, 0.4), bold = true })
	vim.api.nvim_set_hl(0, "LazyH4", { fg = blend(red, orange, 0.6), bold = true })
	vim.api.nvim_set_hl(0, "LazyH5", { fg = blend(red, orange, 0.8), bold = true })
	vim.api.nvim_set_hl(0, "LazyH6", { fg = blend(red, orange, 1), bold = true })

	vim.api.nvim_set_hl(0, "LazySpecial", { fg = fggg })
	vim.api.nvim_set_hl(0, "LazyButton", { fg = type, bold = true })
	vim.api.nvim_set_hl(0, "LazyButtonActive", { fg = blue, bold = true, underline = true })

	vim.api.nvim_set_hl(0, "IndentGuide", { fg = bgg })
	vim.api.nvim_set_hl(0, "IndentGuideScope", { fg = bggggg })
end

return M
