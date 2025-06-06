local colorscheme = require("colorscheme")

local fg = "#d2c9bb"
local bg = "#151515"
local string = "#afaf87"
local keyword = "#af87af"
local constant = "#d7875f"
local red = "#d7675f"
local func = "#87afaf"

local colors = {
	fg = fg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = string,
	type = colorscheme.blend(string, func, 0.8),
	member = colorscheme.blend(keyword, func, 0.5),
	red = red,
	blue = func,
	orange = constant,
}

colorscheme.colorscheme(colors)
