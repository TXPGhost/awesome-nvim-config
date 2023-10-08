-- helper functions
local clear = function(groupname)
	local existing = vim.api.nvim_get_hl(0, { name = groupname })
	vim.api.nvim_set_hl(0, groupname, { link = existing.link })
end

local link = function(from, to)
	vim.api.nvim_set_hl(0, from, { link = to })
end

local set = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { fg = color })
end

local setbg = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { bg = color })
end

local setboth = function(groupname, fgcolor, bgcolor)
	vim.api.nvim_set_hl(0, groupname, { fg = fgcolor, bg = bgcolor })
end

local setbf = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { fg = color, bold = true })
end

local setit = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { fg = color, italic = true })
end

local setitboth = function(groupname, fgcolor, bgcolor)
	vim.api.nvim_set_hl(0, groupname, { fg = fgcolor, bg = bgcolor, italic = true })
end

local setul = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { sp = color, underline = true })
end

local setfgul = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { fg = color, sp = color, underline = true })
end

local setuc = function(groupname, color)
	vim.api.nvim_set_hl(0, groupname, { sp = color, undercurl = true })
end

-- clear all
for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
	clear(hl)
end

-- palette
-- to make `_bg`	https://colorpicker.me/		change lightness from 50 to 10
local white = "#ffffff"
local light_gray = "#cccccc"
local gray = "#888888"
local dark_gray = "#1b1b1b"
local black = "#000000"
local gold = "#ffaa00"
local green = "#00ff77"
local green_bg = "#003318"
local dark_green = "#33bb66"
local red = "#ff2400"
local red_bg = "#330700"
local dark_red = "#ee0033"
local blue = "#0099ff"
local blue_bg = "#001f33"
local light_blue = "#60b3f7"
local light_light_blue = "#9dcdf5"
local cyan = "#00eeff"
local magenta = "#ff44cc"
local orange = "#ff7700"

-- color definitions
clear("TODO")

set("EndOfBuffer", black)
setul("Underlined", white)
set("LineNr", light_gray)
set("LineNrAbove", gray)
set("LineNrBelow", gray)
setbg("Search", dark_gray)

set("OilDirIcon", light_blue)
set("OilDir", light_light_blue)
set("SagaFolder", light_blue)
set("SagaFolderName", light_light_blue)

setbg("NormalFloat", black)
setbg("Pmenu", dark_gray)
setboth("PmenuSel", black, white)

set("Normal", white)
set("Error", red)
setbg("Visual", dark_gray)

setbg("MatchParen", dark_gray)

set("Folded", gray)

set("@type", cyan)
set("@storageclass", cyan)
set("@comment", dark_green)
setbf("@keyword", blue)
setbf("@conditional", blue)
setbf("@repeat", blue)
set("@constant", gold)
set("@constant.builtin", gold)
set("@number", gold)
set("@boolean", gold)
set("@float", gold)
set("@character", gold)
set("@string", gold)
set("@punctuation", light_gray)
setbf("@define", magenta)
setbf("@preproc", magenta)
setbf("@include", magenta)
set("@macro", dark_red)
set("@function.macro", dark_red)
set("@variable.builtin", blue)
set("@namespace", light_blue)
set("@operator", orange)
set("@function", light_light_blue)

set("DiffAdd", green)
set("DiffChange", blue)
set("DiffDelete", red)

setit("DiagnosticError", red)
setit("DiagnosticWarn", gold)
setit("DiagnosticInfo", white)
setit("DiagnosticHint", cyan)
setuc("DiagnosticUnnecessary", cyan)

setuc("DiagnosticUnderlineError", red)
setuc("DiagnosticUnderlineWarn", gold)
setuc("DiagnosticUnderlineInfo", white)
setuc("DiagnosticUnderlineHint", cyan)

set("ErrorMsg", red)

-- lspsaga
set("SagaConstant", gold)
set("SagaNumber", gold)
set("SagaBoolean", gold)
set("SagaString", gold)
set("SagaOperator", light_gray)
set("SagaImpIcon", magenta)
set("SagaMacro", dark_red)
set("SagaNamespace", light_blue)
set("SagaFunction", light_light_blue)

-- gitsigns
setboth("GitSignsAddLn", green, green_bg)
setboth("GitSignsChangeLn", blue, blue_bg)
setboth("GitSignsDeleteVirtLn", red, red_bg)

-- latex
set("@function.latex", blue)
set("@function.macro.latex", red)
set("@text.math.latex", gold)
setbf("@text.environment.latex", blue)
set("@operator.latex", gold)
set("@parameter.latex", gold)
set("@punctuation.special.latex", gold)

-- markdown
setfgul("@text.uri.markdown_inline", blue)
set("@text.reference.markdown_inline", cyan)
setbf("@text.strong.markdown_inline", white)
setit("@text.emphasis.markdown_inline", white)
set("@punctuation.delimiter.markdown_inline", gold)

setbf("@text.title.1.markdown", green)
setbf("@text.title.2.markdown", green)
setbf("@text.title.3.markdown", green)
setbf("@text.title.4.markdown", green)
setbf("@text.title.5.markdown", green)
setbf("@text.title.6.markdown", green)

setbf("@text.title.1.marker.markdown", dark_green)
setbf("@text.title.2.marker.markdown", dark_green)
setbf("@text.title.3.marker.markdown", dark_green)
setbf("@text.title.4.marker.markdown", dark_green)
setbf("@text.title.5.marker.markdown", dark_green)
setbf("@text.title.6.marker.markdown", dark_green)

-- nvim-tree
set("NvimTreeGitNew", green)
