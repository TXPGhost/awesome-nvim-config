-- helper functions
local clear = function(groupname)
	local existing = vim.api.nvim_get_hl(0, { name = groupname })
	vim.api.nvim_set_hl(0, groupname, { link = existing.link })
end

local link = function(from, to)
	vim.api.nvim_set_hl(0, from, { link = to })
end

local set = function(groupname, opts)
	vim.api.nvim_set_hl(0, groupname, opts)
end

-- clear all
for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
	clear(hl)
end

-- palette
local fg = "#ffffff"
local fgg = "#989fb8"
local fggg = "#696e7f"
local bggg = "#666666"
local bgg = "#1f1f1f"
local bg = "#161616"
local bbg = "#131313"
local green = "#32a852"
local red = "#ad2d2d"
local blue = "#407ced"
local greenbg = "#10381b"
local redbg = "#3f1010"
local bluebg = "#112851"
local cyan = "#29eec9"
local lightred = "#ff4c7d"
local magenta = "#e64cf7"
local orange = "#f5ab4a"
local lightgreen = "#aff90c"
local lightblue = "#63cce1"
local brightblue = "#28cced"

local error = "#ff0000"
local warn = "#ffaa00"

-- color definitions
clear("TODO")

set("Normal", { fg = fgg, bg = bbg })
set("Visual", { bg = bgg })
set("Search", { bg = bgg })
set("Folded", { fg = fggg, italic = true })

set("MatchParen", { bg = bgg })

set("LineNr", { fg = bggg, bg = bg })
set("LineNrAbove", { fg = bggg, bg = bg })
set("LineNrBelow", { fg = bggg, bg = bg })
set("StatusLine", { bg = bgg })

set("SignColumn", { bg = bg })
set("FoldColumn", { bg = bg })
set("EndOfBuffer", { fg = bgg, bg = bg })
set("CursorLineNr", { bg = bg })
set("Float", { bg = bgg })

set("Pmenu", { bg = bgg })
set("PmenuSel", { bg = bggg })
set("WinSeparator", { bg = bg, fg = bgg })

set("SagaNormal", { bg = bgg })
set("SagaBorder", { bg = bgg })

local diagnosticOk = fg
local diagnosticHint = brightblue
local diagnosticInfo = fg
local diagnosticWarn = warn
local diagnosticError = error

set("DiagnosticOk", { fg = diagnosticOk })
set("DiagnosticHint", { fg = diagnosticHint })
set("DiagnosticInfo", { fg = diagnosticInfo })
set("DiagnosticWarn", { fg = diagnosticWarn })
set("DiagnosticError", { fg = diagnosticError })
set("DiagnosticVirtualTextOk", { fg = diagnosticOk, italic = true })
set("DiagnosticVirtualTextHint", { fg = diagnosticHint, italic = true })
set("DiagnosticVirtualTextInfo", { fg = diagnosticInfo, italic = true })
set("DiagnosticVirtualTextWarn", { fg = diagnosticWarn, italic = true })
set("DiagnosticVirtualTextError", { fg = diagnosticError, italic = true })
set("DiagnosticSignOk", { fg = diagnosticOk, bg = bg })
set("DiagnosticSignHint", { fg = diagnosticHint, bg = bg })
set("DiagnosticSignInfo", { fg = diagnosticInfo, bg = bg })
set("DiagnosticSignWarn", { fg = diagnosticWarn, bg = bg })
set("DiagnosticSignError", { fg = diagnosticError, bg = bg })
set("DiagnosticUnderlineOk", { sp = diagnosticOk, undercurl = true })
set("DiagnosticUnderlineHint", { sp = diagnosticHint, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = diagnosticInfo, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = diagnosticWarn, undercurl = true })
set("DiagnosticUnderlineError", { sp = diagnosticError, undercurl = true })

set("DiagnosticUnnecessary", { sp = bggg, undercurl = true })

set("@include", { fg = magenta })
set("@define", { fg = magenta })
set("@preproc", { fg = magenta })

set("@punctuation", { fg = fgg })
set("@operator", { fg = fgg })

set("@type", { fg = lightblue })
set("@storageclass", { fg = blue })
set("@type.qualifier", { fg = blue })

set("@variable", { fg = fg })
set("@property", { fg = fg })
set("@parameter", { fg = fg })
set("@field", { fg = fg })

set("@variable.builtin", { fg = blue })

set("@comment", { fg = fggg })
set("Comment", { fg = fggg })

set("@keyword", { fg = cyan })
set("@conditional", { fg = cyan })
set("@repeat", { fg = cyan })

set("@function", { fg = orange })
set("@method", { fg = orange })

set("@macro", { fg = cyan })
set("@function.macro", { fg = cyan })

set("@constant", { fg = lightgreen })
set("@constant.builtin", { fg = lightgreen })
set("@number", { fg = lightgreen })
set("@boolean", { fg = lightgreen })
set("@float", { fg = lightgreen })
set("@character", { fg = lightred })
set("@string", { fg = lightred })

-- markup language
set("@tag", { fg = lightblue })
set("@tag.attribute", { fg = orange })
set("@tag.delimiter", { fg = fgg })

-- xml
set("@string.special.xml", { fg = cyan })

-- git
set("DiffAdd", { fg = green, bg = greenbg })
set("DiffChange", { fg = blue, bg = bluebg })
set("DiffText", { fg = blue, bg = bluebg })
set("DiffDelete", { fg = red, bg = redbg })

set("GitSignsAdd", { fg = green, bg = bg })
set("GitSignsChange", { fg = blue, bg = bg })
set("GitSignsDelete", { fg = red, bg = bg })
set("GitSignsUntracked", { fg = green, bg = bg })

set("GitSignsAddLn", { bg = bgg })
set("GitSignsChangeLn", { bg = bgg })
set("GitSignsDeleteVirtLn", { fg = red, bg = redbg })

set("gitDiff", { fg = fg })
set("diffLine", { fg = fggg })
set("diffAdded", { fg = green })
set("diffRemoved", { fg = red })

set("fugitiveHeader", { fg = lightgreen, bold = true })
set("fugitiveSymbolicRef", { fg = fg })
set("fugitiveUnstagedSection", { fg = red })
set("fugitiveStagedSection", { fg = green })
set("fugitiveUnstagedHeading", { fg = fg, bold = true })
set("fugitiveStagedHeading", { fg = fg, bold = true })
set("fugitiveHelpTag", { fg = fg })
set("fugitiveCount", { fg = fg })

set("@spell.gitcommit", { fg = fg })
set("@text.title.gitcommit", { fg = fgg })

-- neo-tree
set("NeoTreeNormal", { fg = fgg, bg = bg })
set("NeoTreeNormalNC", { fg = fgg, bg = bg })
set("NeoTreeEndOfBuffer", { fg = bg })
set("NeoTreeRootName", { fg = lightgreen })
set("NeoTreeWinSeparator", { bg = bg, fg = bgg })

set("NeoTreeFileName", { fg = fg })
set("NeoTreeFileOpen", { fg = fg, underline = true })
set("NeoTreeModified", { fg = fgg })

set("NeoTreeTitleBar", { fg = fg, bg = bbg })
set("NeoTreeFloatNormal", { fg = fg, bg = bg })
set("NeoTreeFloatBorder", { fg = fg, bg = bg })

-- lspsaga
set("SagaFunction", { fg = orange })
set("SagaStruct", { fg = lightblue })
set("SagaModule", { fg = magenta })
set("SagaNamespace", { fg = magenta })

set("SagaString", { fg = lightred })
set("SagaNumber", { fg = lightgreen })
set("SagaBoolean", { fg = lightgreen })
set("SagaVariable", { fg = cyan })
set("SagaParameter", { fg = fg })

set("CodeActionNumber", { fg = green, bold = true })

-- latex
set("@text.strong.latex", { bold = true })
set("@text.emphasis.latex", { italic = true })
set("@comment.latex", { fg = fggg })
set("@function.latex", { fg = orange })
set("@punctuation.special.latex", { fg = orange })
set("@function.macro.latex", { fg = cyan })
set("@text.environment.latex", { fg = blue })
set("@text.math.latex", { fg = lightred })
set("@operator.latex", { fg = lightred })
set("@parameter.latex", { fg = lightgreen })

-- markdown
set("@text.title.1.markdown", { fg = fg, bold = true })
set("@text.title.2.markdown", { fg = fg, bold = true })
set("@text.title.3.markdown", { fg = fg, bold = true })
set("@text.title.4.markdown", { fg = fg, bold = true })
set("@text.title.5.markdown", { fg = fg, bold = true })
set("@text.title.6.markdown", { fg = fg, bold = true })

set("@text.title.1.marker.markdown", { fg = lightgreen, bold = true })
set("@text.title.2.marker.markdown", { fg = lightgreen, bold = true })
set("@text.title.3.marker.markdown", { fg = lightgreen, bold = true })
set("@text.title.4.marker.markdown", { fg = lightgreen, bold = true })
set("@text.title.5.marker.markdown", { fg = lightgreen, bold = true })
set("@text.title.6.marker.markdown", { fg = lightgreen, bold = true })

set("@text.reference.markdown_inline", { fg = blue })
set("@text.uri.markdown_inline", { fg = cyan, underline = true })
set("@punctuation.delimiter.markdown_inline", { fg = lightred })
set("@punctuation.special.markdown", { fg = orange })
set("@text.strong.markdown_inline", { fg = fg, bold = true })
set("@text.emphasis.markdown_inline", { fg = fg, italic = true })

-- vimdoc
set("@text.reference.vimdoc", { fg = lightblue, underline = true })
set("@label.vimdoc", { fg = orange })
set("@string.special.vimdoc", { fg = cyan })

set("@text.title.1.vimdoc", { fg = lightgreen, bold = true })
set("@text.title.2.vimdoc", { fg = lightgreen, bold = true })
set("@text.title.3.vimdoc", { fg = lightgreen, bold = true })
set("@text.title.4.vimdoc", { fg = lightgreen, bold = true })
set("@text.title.5.vimdoc", { fg = lightgreen, bold = true })
set("@text.title.6.vimdoc", { fg = lightgreen, bold = true })

-- crates
set("CratesNvimVersion", { fg = fggg, italic = true })
