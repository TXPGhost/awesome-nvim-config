local colorscheme = require("colorscheme")

local fg = "#d1cbc2"
local bg = "#191919"

local fgg = colorscheme.blend(bg, fg, 0.85)
local fggg = colorscheme.blend(bg, fg, 0.7)
local fgggg = colorscheme.blend(bg, fg, 0.55)
local fggggg = colorscheme.blend(bg, fg, 0.4)

local bgg = colorscheme.blend(bg, fg, 0.01)
local bggg = colorscheme.blend(bg, fg, 0.02)
local bgggg = colorscheme.blend(bg, fg, 0.03)
local bggggg = colorscheme.blend(bg, fg, 0.04)
local bgggggg = colorscheme.blend(bg, fg, 0.05)

local string = "#d8a147"
local green = "#82c155"
local keyword = "#9295db"
local constant = "#e55b67"
local type = "#9eced3"
local func = "#669bbc"
local member = "#adb9ce"
local orange = "#d17754"

local colors = {
	fg = fg,
	fgg = fgg,
	fggg = fggg,
	fgggg = fgggg,
	fggggg = fggggg,
	bg = bg,
	bgg = bgg,
	bggg = bggg,
	bgggg = bgggg,
	bggggg = bggggg,
	bgggggg = bgggggg,
	string = string,
	keyword = keyword,
	constant = constant,
	func = func,
	green = green,
	type = type,
	member = member,
	red = constant,
	blue = func,
	orange = orange,
}

colorscheme.colorscheme(colors)
