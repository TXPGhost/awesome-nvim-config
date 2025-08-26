local colorscheme = require("colorscheme")

local fg = "#cdcdcd"
local bg = "#141415"
local string = "#e0a363"
local green = "#a3cd81"
local keyword = "#81a2be"
local blue = "#6d92b0"
local constant = "#c48280"
local func = "#bb9dbd"
local type = "#b4d4cf"
local member = "#aeaed1"
local orange = string

local colors = {
	fg = fg,
	fgg = colorscheme.blend(bg, fg, 0.85),
	fggg = colorscheme.blend(bg, fg, 0.7),
	fgggg = colorscheme.blend(bg, fg, 0.55),
	fggggg = colorscheme.blend(bg, fg, 0.4),
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = type,
	member = member,
	red = constant,
	blue = blue,
	orange = string,
}

colorscheme.colorscheme(colors)
