local colorscheme = require("colorscheme")

local fg = "#d8d8d8"
local bg = "#181818"
local keyword = "#ba8baf"
local string = "#c46360"
local constant = "#dc9656"
local type = "#f7ca88"
local func = "#7cafc2"
local member = "#a1b56c"
local green = member
local red = string
local blue = func

local colors = {
	fg = fg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = type,
	member = member,
	red = constant,
	blue = func,
	heading = constant,
}

colorscheme.colorscheme(colors)
