local colorscheme = require("colorscheme")

local fg = "#d2c9bb"
local fgg = "#9e978c"
local fggg = "#757068"
local fgggg = "#6b665f"
local fggggg = "#514e48"
local bg = "#1e1f1f"
local string = "#6293bb"
local keyword = "#d1b78e"
local constant = "#c64640"
local func = "#d1a764"

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
	green = string,
	type = colorscheme.blend(string, func, 0.8),
	member = colorscheme.blend(keyword, func, 0.5),
	red = constant,
	blue = string,
	orange = constant,
}

colorscheme.colorscheme(colors)
