---@diagnostic disable: undefined-global

local lush = require("lush")

local hsl = lush.hsl

local black = hsl(0, 0, 0)
local white = hsl(0, 0, 100)

local magenta = hsl(300, 80, 30)
local green = hsl(120, 40, 40)

return lush(function(injected_functions)
	local sym = injected_functions.sym

	return {
		Normal({ bg = white, fg = black }),
		PMenu({ bg = white, fg = black }),
		Float({ bg = white, fg = black }),
		Statement({ bg = white, fg = black }),
		Special({ bg = white, fg = black }),
		Identifier({ bg = white, fg = black }),
		Comment({ bg = white, fg = black }),
		Type({ bg = white, fg = black }),
		PreProc({ bg = white, fg = black }),

		sym("@keyword")({ fg = magenta }),
		Constant({ fg = green }),

		MatchParen({}),

		Conceal({ bg = white, fg = black }),

		TermCursor({ bg = white, fg = black }),
		Cursor({ bg = white, fg = black }),
		CursorColumn({ bg = white, fg = black }),
		CursorLine({ bg = white, fg = black }),
		CursorLineNr({ bg = white, fg = black }),
		CursorLineFold({ bg = white, fg = black }),
		CursorSign({ bg = white, fg = black }),

		LineNr({ bg = white, fg = black }),
		SignColumn({ bg = white, fg = black }),
		EndOfBuffer({ bg = white, fg = black }),

		DiagnosticError({ bg = white, fg = black }),
		DiagnosticWarn({ bg = white, fg = black }),
		DiagnosticHint({ bg = white, fg = black }),
		DiagnosticInfo({ bg = white, fg = black }),
		DiagnosticOk({ bg = white, fg = black }),

		DiagnosticUnderlineError({ sp = black, undercurl = true }),
		DiagnosticUnderlineWarn({ sp = black, undercurl = true }),
		DiagnosticUnderlineHint({ sp = black, undercurl = true }),
		DiagnosticUnderlineInfo({ sp = black, undercurl = true }),
		DiagnosticUnderlineOk({ sp = black, undercurl = true }),

		GitSignsAdd({ bg = white, fg = black }),
		GitSignsChange({ bg = white, fg = black }),
		GitSignsDelete({ bg = white, fg = black }),

		Title({ bg = white, fg = black }),
		Directory({ bg = white, fg = black }),
	}
end)
