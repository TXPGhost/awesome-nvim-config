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
local keyword = "#29eec9"
local string = "#ff4c7d"
local include = "#e64cf7"
local func = "#f5ab4a"
local constant = "#aff90c"
local type = "#63cce1"

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

set("@include", { fg = include })
set("@define", { fg = include })
set("@preproc", { fg = include })

set("@punctuation", { fg = fgg })
set("@operator", { fg = fgg })

set("@type", { fg = type })

set("@variable", { fg = fg })
set("@property", { fg = fg })
set("@parameter", { fg = fg })
set("@field", { fg = fg })

set("@variable.builtin", { fg = blue })

set("@comment", { fg = fggg })
set("Comment", { fg = fggg })

set("@keyword", { fg = keyword })
set("@conditional", { fg = keyword })
set("@repeat", { fg = keyword })

set("@function", { fg = func })

set("@macro", { fg = keyword })
set("@function.macro", { fg = keyword })
set("@lsp.type.macro", { fg = keyword })

set("@constant", { fg = constant })
set("@constant.builtin", { fg = constant })
set("@constructor", { fg = constant })
set("@number", { fg = constant })
set("@boolean", { fg = constant })
set("@float", { fg = constant })
set("@character", { fg = string })
set("@string", { fg = string })
