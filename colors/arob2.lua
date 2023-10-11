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
local bg1 = "#151515"
local bg0 = "#050505"

-- color definitions
clear("TODO")

set("Normal", { fg = fg, bg = bg1 })
set("LineNr", { bg = bg0 })
set("LineNrAbove", { bg = bg0 })
set("LineNrBelow", { bg = bg0 })
set("SignColumn", { bg = bg0 })
set("EndOfBuffer", { bg = bg0 })
set("CursorLineNr", { bg = bg0 })

link("GitSignsAdd", "SignColumn")
link("GitSignsChange", "SignColumn")
link("GitSignsRemove", "SignColumn")
link("GitSignsUntracked", "SignColumn")
