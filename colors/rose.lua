local colorscheme = require("colorscheme")

local fg = "#c7c1c8"
local fgg = "#8b8b8b"
local fggg = "#777777"
local fgggg = "#646464"
local fggggg = "#515151"
local bg = "#1e1f1f"
local string = "#9a6e3f"
local green = "#809376"
local keyword = "#c17370"
local member = "#8c95a1"
local type = "#96a0ad"
local constant = "#934746"
local func = "#ad717a"

local colors = {
	fg = fg,
	fgg = fgg,
	fggg = fggg,
	fgggg = fgggg,
	fggggg = fggggg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = type,
	member = member,
	red = constant,
	blue = member,
	orange = string,
}

colorscheme.colorscheme(colors)
