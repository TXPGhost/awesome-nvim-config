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
local white = "#ffffff"
local light_gray = "#cccccc"
local gray = "#888888"
local dark_gray = "#1b1b1b"
local black = "#000000"
local gold = "#ffaa00"
local green = "#00ff77"
local dark_green = "#33bb66"
local red = "#ff2400"
local dark_red = "#ee0033"
local blue = "#0099ff"
local light_blue = "#60b3f7"
local light_light_blue = "#9dcdf5"
local cyan = "#00eeff"
local magenta = "#ff44cc"

-- color definitions
set("EndOfBuffer", black)
setul("Underlined", white)
set("LineNr", gray)

set("OilDirIcon", light_blue)
set("OilDir", light_light_blue)

setbg("NormalFloat", black)
setbg("Pmenu", dark_gray)
setboth("PmenuSel", black, white)

setfgul("TODO", dark_green)

set("Normal", white)
set("Error", red)
setbg("Visual", dark_gray)
set("Special", gold)

set("@type", cyan)
set("@storageclass", cyan)
set("@comment", dark_green)
setbf("@keyword", blue)
setbf("@conditional", blue)
setbf("@repeat", blue)
set("@constant", gold)
set("@number", gold)
set("@boolean", gold)
set("@float", gold)
set("@character", gold)
set("@string", gold)
set("@operator", light_gray)
setbf("@define", magenta)
setbf("@preproc", magenta)
setbf("@include", magenta)
setit("@macro", dark_red)
setit("@function", light_gray)
set("@punctuation", light_gray)

set("DiffAdd", green)
set("DiffChange", blue)
set("DiffDelete", red)

setit("DiagnosticError", red)
setit("DiagnosticWarn", gold)
setit("DiagnosticInfo", white)
setit("DiagnosticHint", cyan)
set("DiagnosticUnnecessary", white)

setuc("DiagnosticUnderlineError", red)
setuc("DiagnosticUnderlineWarn", gold)
setuc("DiagnosticUnderlineInfo", white)
setuc("DiagnosticUnderlineHint", cyan)

set("ErrorMsg", red)

-- nvim-tree
set("NvimTreeGitNew", green)

-- language specific
link("luaTable", "Operator")
link("luaFunction", "Keyword")
