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
local blue = "#2b61c4"
local greenbg = "#10381b"
local redbg = "#3a0f0f"
local bluebg = "#0e2042"
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

set("Normal", { fg = fg, bg = bg })
set("Visual", { bg = bgg })
set("LineNr", { fg = bggg, bg = bbg })
set("LineNrAbove", { fg = bggg, bg = bbg })
set("LineNrBelow", { fg = bggg, bg = bbg })
set("SignColumn", { bg = bbg })
set("EndOfBuffer", { fg = bbg, bg = bbg })
set("CursorLineNr", { bg = bbg })
set("Pmenu", { bg = bgg })
set("Float", { bg = bgg })

set("SagaNormal", { bg = bgg })
set("SagaBorder", { bg = bgg })

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
set("GitSignsChange", { fg = blue, bg = bbg })
set("GitSignsDelete", { fg = red, bg = bbg })
set("GitSignsUntracked", { fg = green, bg = bbg })

set("GitSignsAddLn", { bg = greenbg })
set("GitSignsChangeLn", { bg = bluebg })
set("GitSignsDeleteVirtLn", { bg = redbg })

set("@include", { fg = include })
set("@define", { fg = include })
set("@preproc", { fg = include })

set("@punctuation", { fg = fgg })
set("@operator", { fg = fgg })

set("@type", { fg = type })

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
set("@number", { fg = constant })
set("@boolean", { fg = constant })
set("@float", { fg = constant })
set("@character", { fg = string })
set("@string", { fg = string })
