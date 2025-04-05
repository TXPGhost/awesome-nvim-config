local colorscheme = require("colorscheme")

local fg = "#d2c9bb"
local bg = "#151515"
local string = "#afaf87"
local keyword = "#af87af"
local constant = "#d7875f"
local func = "#87afaf"
local green = "#8fb573"

local colors = {
	fg = fg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = colorscheme.blend(string, func, 0.8),
	member = colorscheme.blend(keyword, func, 0.5),
	red = constant,
	blue = func,
	heading = string,
}

colorscheme.colorscheme(colors)
