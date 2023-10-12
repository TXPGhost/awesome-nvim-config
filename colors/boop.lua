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
local bgg = "#262626"
local bg = "#1f1f1f"
local bbg = "#161616"
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

local error = "#ff0000"
local warn = "#ffaa00"

-- color definitions
clear("TODO")

set("Normal", { fg = fgg, bg = bg })
set("Visual", { bg = bgg })

set("LineNr", { fg = bggg, bg = bbg })
set("LineNrAbove", { fg = bggg, bg = bbg })
set("LineNrBelow", { fg = bggg, bg = bbg })
set("StatusLine", { bg = bgg })

set("SignColumn", { bg = bbg })
set("EndOfBuffer", { fg = bgg, bg = bbg })
set("CursorLineNr", { bg = bbg })
set("Pmenu", { bg = bgg })
set("Float", { bg = bgg })

set("SagaNormal", { bg = bgg })
set("SagaBorder", { bg = bgg })

set("OilFile", { fg = fg })

set("DiagnosticOk", { fg = fg })
set("DiagnosticHint", { fg = warn })
set("DiagnosticInfo", { fg = fg })
set("DiagnosticWarn", { fg = warn })
set("DiagnosticError", { fg = error })
set("DiagnosticVirtualTextOk", { fg = fg, italic = true })
set("DiagnosticVirtualTextHint", { fg = warn, italic = true })
set("DiagnosticVirtualTextInfo", { fg = fg, italic = true })
set("DiagnosticVirtualTextWarn", { fg = warn, italic = true })
set("DiagnosticVirtualTextError", { fg = error, italic = true })
set("DiagnosticSignOk", { fg = fg })
set("DiagnosticSignHint", { fg = warn })
set("DiagnosticSignInfo", { fg = fg })
set("DiagnosticSignWarn", { fg = warn })
set("DiagnosticSignError", { fg = error })
set("DiagnosticSignOk", { bg = bbg })
set("DiagnosticSignHint", { bg = bbg })
set("DiagnosticSignInfo", { bg = bbg })
set("DiagnosticSignWarn", { bg = bbg })
set("DiagnosticSignError", { bg = bbg })

set("GitSignsAdd", { fg = green, bg = bbg })
set("GitSignsChange", { fg = green, bg = bbg })
set("GitSignsDelete", { fg = red, bg = bbg })
set("GitSignsUntracked", { fg = green, bg = bbg })

set("GitSignsAddLn", { fg = green, bg = greenbg })
set("GitSignsChangeLn", { fg = green, bg = greenbg })
set("GitSignsDeleteVirtLn", { fg = red, bg = redbg })

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

set("@spell.gitcommit", { fg = fg })
set("@text.title.gitcommit", { fg = fgg })

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
