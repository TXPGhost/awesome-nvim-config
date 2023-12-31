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
local cyan = "#29eec9"
local lightred = "#ff4c7d"
local magenta = "#e64cf7"
local orange = "#f5ab4a"
local lightgreen = "#aff90c"
local lightblue = "#63cce1"
local brightblue = "#28cced"
local brightbluebg = "#131c1e"
local bluebg = "#13181e"
local greenbg = "#131a13"
local redbg = "#1a1313"
local gold = "#ffaa00"
local goldbg = "#1e1a13"

local searchbg = "#1f283a"

local brightred = "#ff0000"

-- color definitions
clear("TODO")

set("Normal", { fg = fg, bg = bbg })
set("Visual", { bg = bgg })
set("Search", { bg = searchbg })
set("CurSearch", { bg = searchbg })
set("IncSearch", { bg = searchbg })
set("Folded", { fg = fggg, italic = true })

set("MatchParen", { bg = bgg })

set("LineNr", { fg = bggg, bg = bg })
set("LineNrAbove", { fg = bggg, bg = bg })
set("LineNrBelow", { fg = bggg, bg = bg })
set("StatusLine", { bg = bgg })
set("StatusLineNC", { bg = bg })

set("SignColumn", { bg = bg })
set("FoldColumn", { bg = bg })
set("EndOfBuffer", { fg = blue, bg = bg })
set("CursorLineNr", { bg = bg })
set("Float", { bg = bgg })

set("Pmenu", { bg = bgg })
set("PmenuSel", { bg = bggg })
set("WinSeparator", { bg = bg, fg = bgg })

set("SagaNormal", { bg = bgg })
set("SagaBorder", { bg = bgg })

set("DiagnosticOk", { fg = fg })
set("DiagnosticInfo", { fg = brightblue })
set("DiagnosticHint", { fg = brightblue })
set("DiagnosticWarn", { fg = gold })
set("DiagnosticError", { fg = brightred })

set("DiagnosticVirtualTextOk", { fg = fg, italic = true })
set("DiagnosticVirtualTextInfo", { fg = brightblue, italic = true })
set("DiagnosticVirtualTextHint", { fg = brightblue, bg = brightbluebg, italic = true })
set("DiagnosticVirtualTextWarn", { fg = gold, bg = goldbg, italic = true })
set("DiagnosticVirtualTextError", { fg = brightred, bg = redbg, italic = true })

set("DiagnosticSignOk", { fg = fg, bg = bg })
set("DiagnosticSignInfo", { fg = brightblue, bg = bg })
set("DiagnosticSignHint", { fg = brightblue, bg = bg })
set("DiagnosticSignWarn", { fg = gold, bg = bg })
set("DiagnosticSignError", { fg = brightred, bg = bg })

set("DiagnosticUnderlineOk", { sp = fg, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = brightblue, undercurl = true })
set("DiagnosticUnderlineHint", { sp = brightblue, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = gold, undercurl = true })
set("DiagnosticUnderlineError", { sp = brightred, undercurl = true })

set("DiagnosticUnnecessary", { sp = bggg, undercurl = true })

set("@include", { fg = magenta })
set("@define", { fg = magenta })
set("@preproc", { fg = magenta })

set("@attribute", { fg = fgg })

set("@punctuation", { fg = fgg })
set("@operator", { fg = fgg })

set("@type", { fg = lightblue })
set("@storageclass", { fg = blue })
set("@type.qualifier", { fg = blue })

set("@variable", { fg = fg })
set("@property", { fg = fg })
set("@parameter", { fg = fg })
set("@field", { fg = fg })

set("@variable.builtin", { fg = magenta })
set("@function.builtin", { fg = magenta })

set("@comment", { fg = fggg })
set("Comment", { fg = fggg })

set("@keyword", { fg = cyan })
set("@conditional", { fg = cyan })
set("@repeat", { fg = cyan })
set("@exception", { fg = cyan })

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

-- cmp
set("CmpItemAbbr", { fg = fgg })
set("CmpItemAbbrMatch", { fg = fg })

set("CmpItemKind", { fg = fg })

set("CmpItemKindSnippet", { fg = lightred })

set("CmpItemKindVariable", { fg = lightgreen })
set("CmpItemKindConstant", { fg = lightgreen })
set("CmpItemKindField", { fg = lightblue })
set("CmpItemKindProperty", { fg = lightblue })

set("CmpItemKindFunction", { fg = orange })
set("CmpItemKindMethod", { fg = orange })
set("CmpItemKindConstructor", { fg = orange })

set("CmpItemKindEnum", { fg = blue })
set("CmpItemKindClass", { fg = blue })
set("CmpItemKindStruct", { fg = blue })
set("CmpItemKindInterface", { fg = blue })

set("CmpItemKindModule", { fg = magenta })

-- telescope
set("TelescopeTitle", { fg = fg })

set("TelescopeMatching", { fg = fg })
set("TelescopeSelection", { bg = bgg })
set("TelescopeSelectionCaret", { fg = fg, bg = bgg })
set("TelescopeMultiSelection", { bg = bg })
set("TelescopeMultiIcon", { fg = fg, bg = bg })

set("TelescopeResultsVariable", { fg = fg })
set("TelescopeResultsIdentifier", { fg = fg })
set("TelescopeResultsConstant", { fg = lightgreen })
set("TelescopeResultsNumber", { fg = lightgreen })
set("TelescopeResultsField", { fg = fg })
set("TelescopeResultsFunction", { fg = orange })
set("TelescopeResultsMethod", { fg = orange })
set("TelescopeResultsClass", { fg = lightblue })
set("TelescopeResultsStruct", { fg = lightblue })

-- oil
set("OilDir", { fg = blue })
set("OilFile", { fg = fg })

-- ocaml
set("@constructor.ocaml", { fg = lightgreen })

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

set("GitSignsAddLn", { bg = bluebg })
set("GitSignsChangeLn", { bg = bluebg })
set("GitSignsDeleteVirtLn", { fg = red, bg = redbg, italic = true })
set("GitSignsDeleteVirtLnInline", { fg = red, bg = redbg, strikethrough = true, italic = true })

set("gitDiff", { fg = fg })
set("diffLine", { fg = fggg })
set("diffAdded", { fg = green })
set("diffRemoved", { fg = red })

set("fugitiveHeader", { fg = lightgreen, bold = true })
set("fugitiveSymbolicRef", { fg = fg })
set("fugitiveUnstagedSection", { fg = red })
set("fugitiveUntrackedSection", { fg = orange })
set("fugitiveStagedSection", { fg = green })
set("fugitiveUnstagedHeading", { fg = fg, bold = true })
set("fugitiveUntrackedHeading", { fg = fg, bold = true })
set("fugitiveStagedHeading", { fg = fg, bold = true })
set("fugitiveHelpTag", { fg = fg })
set("fugitiveCount", { fg = fg })

set("@spell.gitcommit", { fg = fg })
set("@text.title.gitcommit", { fg = fgg })

-- code action
set("CodeActionMenuMenuTitle", { bg = bgg })
set("CodeActionMenuMenuIndex", { fg = green, bold = true })

-- makefile
set("@symbol.make", { fg = magenta })
set("@function.builtin.make", { fg = blue })
set("@operator.make", { fg = lightgreen })

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
set("@text.literal.markdown_inline", { fg = fg })
set("@text.strong.markdown_inline", { fg = fg, bold = true })
set("@text.emphasis.markdown_inline", { fg = fg, italic = true })

-- vim plug
set("plug1", { fg = lightgreen, bold = true })
set("plug2", { fg = lightred })
set("plugH2", { fg = magenta })
set("plugNumber", { fg = fg })
set("plugUpdate", { fg = orange })
set("plugMessage", { fg = fg })
set("plugCommit", { fg = fg })
set("plugSha", { fg = orange })
set("plugName", { fg = blue })
set("plugBracket", { fg = lightblue })
set("plugDeleted", { fg = red })

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
