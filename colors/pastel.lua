local function blend(hex1, hex2, t)
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

local fg = "#d1cbc2"
local bg = "#191919"
local string = "#d8a147"
local keyword = "#9295db"
local keyword_mod = "#7d80c1"
local number = "#e55b67"
local type = "#9eced3"
local green = "#82c155"
local func = "#669bbc"
local member = "#adb9ce"
local red = number
local blue = func

local fgg = blend(bg, fg, 0.85)
local fggg = blend(bg, fg, 0.7)
local fgggg = blend(bg, fg, 0.55)
local fggggg = blend(bg, fg, 0.4)

local bgg = blend(bg, fg, 0.01)
local bggg = blend(bg, fg, 0.02)
local bgggg = blend(bg, fg, 0.03)
local bggggg = blend(bg, fg, 0.04)
local bgggggg = blend(bg, fg, 0.05)

vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
vim.api.nvim_set_hl(0, "Identifier", { fg = number })
vim.api.nvim_set_hl(0, "Statement", {})
vim.api.nvim_set_hl(0, "Function", { fg = func })
vim.api.nvim_set_hl(0, "Constant", { fg = number })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = number })
vim.api.nvim_set_hl(0, "Special", {})
vim.api.nvim_set_hl(0, "Operator", { fg = fggg })
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bgggg, fg = fgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggggg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bggg })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = bggg, fg = fggggg })
vim.api.nvim_set_hl(0, "Type", { fg = type })
vim.api.nvim_set_hl(0, "PreProc", { fg = number })
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
vim.api.nvim_set_hl(0, "MsgArea", { fg = fgg, bg = bg })
vim.api.nvim_set_hl(0, "WinBar", { fg = fgg, bg = bg, italic = true })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = fggg, bg = bg, italic = true })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fgg, bg = bgg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg, bg = bgg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bgggg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bggg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bgg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bgggg, bg = bg })
vim.api.nvim_set_hl(0, "Visual", { bg = bgggg })
vim.api.nvim_set_hl(0, "Search", { reverse = true })
vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bggg })
vim.api.nvim_set_hl(0, "Title", { fg = string })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bgggg })
vim.api.nvim_set_hl(0, "Error", { fg = number, bg = blend(number, bg, 0.9) })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = number, bg = blend(number, bg, 0.9) })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = number, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { fg = green, bg = blend(green, bg, 0.9) })
vim.api.nvim_set_hl(0, "diffChanged", { fg = number, bg = blend(keyword_mod, bg, 0.9) })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = number, bg = blend(number, bg, 0.9) })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { fg = number, bg = blend(number, bg, 0.8) })
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = blue })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = green })
vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = blend(green, blue, 0.33) })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = blend(green, blue, 0.66) })
vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = blue })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = func })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = string })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = number })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = keyword_mod, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = string, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = number, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = fggg })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = fg, bg = blend(fg, bg, 0.95), italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = fg, bg = blend(fg, bg, 0.95), italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = func, bg = blend(keyword_mod, bg, 0.95), italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = string, bg = blend(string, bg, 0.95), italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = number, bg = blend(number, bg, 0.95), italic = true })

vim.api.nvim_set_hl(0, "@punctuation", { link = "Operator" })
vim.api.nvim_set_hl(0, "@punctuation.special", { link = "Operator" })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@keyword", { fg = keyword, italic = true })
vim.api.nvim_set_hl(0, "@keyword.modifier", { fg = keyword_mod, italic = true })
vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@function", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })

vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = member })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { fg = number })

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

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = number, bold = true })
vim.api.nvim_set_hl(
	0,
	"@markup.heading.1.markdown",
	{ fg = blend(number, keyword_mod, 0), bold = true, underline = true }
)
vim.api.nvim_set_hl(
	0,
	"@markup.heading.2.markdown",
	{ fg = blend(number, keyword_mod, 0.2), bold = true, underline = true }
)
vim.api.nvim_set_hl(
	0,
	"@markup.heading.3.markdown",
	{ fg = blend(number, keyword_mod, 0.4), bold = true, underline = true }
)
vim.api.nvim_set_hl(
	0,
	"@markup.heading.4.markdown",
	{ fg = blend(number, keyword_mod, 0.6), bold = true, underline = true }
)
vim.api.nvim_set_hl(
	0,
	"@markup.heading.5.markdown",
	{ fg = blend(number, keyword_mod, 0.8), bold = true, underline = true }
)
vim.api.nvim_set_hl(
	0,
	"@markup.heading.6.markdown",
	{ fg = blend(number, keyword_mod, 1), bold = true, underline = true }
)

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = number })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = fgggg })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = func, bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = func, italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "@punctuation" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = fg, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = type })

vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = fgggg })

vim.api.nvim_set_hl(0, "@markup.strong.latex", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.latex", { italic = true })

vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

vim.api.nvim_set_hl(0, "@markup.link.gitcommit", { link = "Type" })
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = string })

vim.api.nvim_set_hl(0, "@function.make", { fg = string })
vim.api.nvim_set_hl(0, "@function.cmake", { fg = string })
vim.api.nvim_set_hl(0, "@function.latex", { fg = string })

vim.api.nvim_set_hl(0, "@keyword.import.latex", { fg = number })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = func })

vim.api.nvim_set_hl(0, "@punctuation.delimiter.comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@comment.todo.comment", { bg = bgggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.note.comment", { bg = bgggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.warning.comment", { fg = string, bg = bgggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.error.comment", { fg = number, bg = bgggg, bold = true })

vim.api.nvim_set_hl(0, "@function.call.rust", { fg = fg })

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

vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = blue })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = fggg })

vim.api.nvim_set_hl(0, "CmpItemKind", { fg = fgg })

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = green })

vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = type })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = type })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = type })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = type })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = type })

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = number })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = keyword })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fggg })
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = member })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fg })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = func })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = func })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = number })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = number })

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

vim.api.nvim_set_hl(0, "Terminal", { bg = bbg })

vim.api.nvim_set_hl(0, "LspInlayHint", { fg = fggggg })

vim.api.nvim_set_hl(0, "MiniStatuslineDevInfo", { fg = fgg, bg = bgggg })
vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { fg = fgg, bg = bgggg })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = fgg, bg = bgg })

vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = fgg, bg = bggggg })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = fgg, bg = bggggg })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = fgg, bg = bggggg })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = fgg, bg = bggggg })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = fgg, bg = bggggg })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { fg = fgg, bg = bggggg })

vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { link = "PmenuSel" })

vim.api.nvim_set_hl(0, "WinBar", { fg = fgg, bg = bgg, italic = false })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = fggg, bg = bgg, italic = false })

vim.api.nvim_set_hl(0, "@constructor.ocaml", { link = "Constant" })
