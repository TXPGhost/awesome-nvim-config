---@diagnostic disable: undefined-global

local lush = require("lush")

local hsl = lush.hsl

local bg = hsl(0, 0, 8)
local fg = hsl(0, 0, 93)
local acc = hsl(200, 65, 60)
local acc2 = hsl(200, 75, 50)
local acc3 = hsl(0, 83, 58)

local fgd = fg.darken(20)
local fgdd = fg.darken(35)
local fgddd = fg.darken(60)
local accl = acc.lighten(20)
local accd = acc.darken(20)
local accdd = acc.darken(30)
local acc2d = acc2.darken(20)

return lush(function(injected_functions)
	local sym = injected_functions.sym

	return {
		Normal({ bg = bg, fg = fg }),
		PMenu({ bg = bg, fg = fg }),
		Float({ bg = bg, fg = fg }),
		Statement({ bg = bg, fg = fgd }),
		Special({ bg = bg, fg = fgd }),
		Identifier({ bg = bg, fg = fg }),
		Comment({ bg = bg, fg = fgddd }),
		Type({ bg = bg, fg = acc2 }),
		PreProc({ bg = bg, fg = acc3 }),
		Constant({ bg = bg, fg = accl }),
		sym("@storageclass")({ bg = bg, fg = accd }),
		sym("@type.qualifier")({ bg = bg, fg = acc }),

		EndOfBuffer({ fg = accdd }),
		Directory({ fg = accl }),

		sym("@keyword")({ fg = acc }),
		sym("@field")({ fg = acc }),
		sym("@lsp.type.property")({ fg = accl }),

		LineNr({ bg = bg, fg = fgdd }),

		SignColumn({ bg = bg, fg = fg }),
		GitSignsAdd({ bg = bg, fg = fg }),
		GitSignsChange({ bg = bg, fg = fg }),
		GitSignsDelete({ bg = bg, fg = fg }),
	}
end)
