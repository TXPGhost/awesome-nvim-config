local colorscheme = require("colorscheme")

local fg = "#d1d1d1"
local bg = "#1a1a19"
local string = "#86af9a"
local constant = "#86af9a"
local keyword = "#95b3d1"
local red = "#d7675f"
local func = "#f6c699"
local type = "#eea86b"

local colors = {
	fg = fg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = string,
	type = type,
	member = colorscheme.blend(keyword, fg, 0.5),
	red = red,
	blue = keyword,
	orange = type,
}

colorscheme.colorscheme(colors)
