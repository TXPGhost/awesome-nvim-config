local colorscheme = require("colorscheme")

local fg = "#d0d0d0"
local bg = "#161616"
local string = "#b897f9"
local green = "#53b762"
local member = "#82a8f8"
local keyword = member
local type = "#ee7cb6"
local constant = "#94cdfa"
local func = "#71d8d8"
local red = "#ed7b82"
local orange = "#eda37b"

type = func
func = fg

local colors = {
	fg = fg,
	-- fgg = fgg,
	-- fggg = fggg,
	-- fgggg = fgggg,
	-- fggggg = fggggg,
	bg = bg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = type,
	member = member,
	red = red,
	blue = member,
	orange = orange,
}

colorscheme.colorscheme(colors)
