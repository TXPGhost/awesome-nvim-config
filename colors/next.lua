local fg = "#e1e4e8"
local fgg = "#a6acb3"
local fggg = "#6a737d"
local fgggg = "#585E64"
local fggggg = "#363a3f"

local bg = "#1a1a1a"
local bgg = "#1f1f1f"
local bggg = "#242424"
local bgggg = "#292929"
local bggggg = "#2e2e2e"
local bgggggg = "#333333"

local red = "#f97583"
local green = "#85e89d"
local blue = "#79b8ff"
local lightblue = "#9ecbff"
local orange = "#ffab70"
local purple = "#b392f0"

local redbg = "#2C1F1D"
local greenbg = "#232C23"
local bluebg = "#1D2228"
local bluebgg = "#242b33"

-- terminal
vim.g.terminal_color_0 = fggg       -- black
vim.g.terminal_color_1 = red        -- red
vim.g.terminal_color_2 = green      -- green
vim.g.terminal_color_3 = orange     -- yellow
vim.g.terminal_color_4 = blue       -- blue
vim.g.terminal_color_5 = purple     -- magenta
vim.g.terminal_color_6 = lightblue  -- cyan
vim.g.terminal_color_7 = fgg        -- white
vim.g.terminal_color_8 = fggg       -- black (bright)
vim.g.terminal_color_9 = red        -- red (bright)
vim.g.terminal_color_10 = green     -- green (bright)
vim.g.terminal_color_11 = orange    -- yellow (bright)
vim.g.terminal_color_12 = blue      -- blue (bright)
vim.g.terminal_color_13 = purple    -- magenta (bright)
vim.g.terminal_color_14 = lightblue -- cyan (bright)
vim.g.terminal_color_15 = fgg       -- white (bright)

vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bgg })
vim.api.nvim_set_hl(0, "Identifier", { fg = fg })
vim.api.nvim_set_hl(0, "Statement", { fg = red, italic = true })
vim.api.nvim_set_hl(0, "Function", { fg = purple })
vim.api.nvim_set_hl(0, "Constant", { fg = lightblue })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = orange })
vim.api.nvim_set_hl(0, "Special", {})
vim.api.nvim_set_hl(0, "Operator", { fg = red })
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bggggg, fg = fgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggggg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bggggg })
vim.api.nvim_set_hl(0, "Type", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "PreProc", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "String", { fg = lightblue })
vim.api.nvim_set_hl(0, "Character", { fg = lightblue })
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "FoldColumn", {})
vim.api.nvim_set_hl(0, "Directory", { fg = lightblue })
vim.api.nvim_set_hl(0, "ModeMsg", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = fgggg })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fggggg })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fggggg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = fggggg })
vim.api.nvim_set_hl(0, "CursorLine", { bg = bggg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fgggg })
vim.api.nvim_set_hl(0, "MsgArea", { bg = bg })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fgg, bg = bggg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg, bg = bggg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bggggg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bgggg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bggg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bggggg, bg = bg })
vim.api.nvim_set_hl(0, "Visual", { bg = bggggg })
vim.api.nvim_set_hl(0, "Search", { reverse = true })
vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bgggg })
vim.api.nvim_set_hl(0, "Title", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bggggg })
vim.api.nvim_set_hl(0, "Error", { fg = orange, bg = redbg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = orange, bg = redbg })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = lightblue, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { fg = green, bg = greenbg })
vim.api.nvim_set_hl(0, "diffChanged", { fg = blue, bg = bluebg })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { bg = bluebgg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = blue })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = green })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = orange })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = red, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = green, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = orange, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = fggg })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = red, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = green, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = orange, italic = true })

vim.api.nvim_set_hl(0, "@punctuation", { fg = fgg })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fgg })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@keyword", { link = "Statement" })
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })

vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = orange })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { link = "PreProc" })
vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "PreProc" })

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
vim.api.nvim_set_hl(0, "@lsp.type", { link = "Type" })
vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@module" })
vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.modifier", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.annotation", { link = "PreProc" })
vim.api.nvim_set_hl(0, "@string.escape", { link = "Character" })

vim.api.nvim_set_hl(0, "@lsp.type.macro.c", {})
vim.api.nvim_set_hl(0, "@lsp.type.macro.cpp", {})

vim.api.nvim_set_hl(0, "@lsp.type.attributeBracket", {})
vim.api.nvim_set_hl(0, "@lsp.type.builtinAttribute", {})
vim.api.nvim_set_hl(0, "@lsp.type.generic", {})

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = lightblue, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = blue, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = blue, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = blue, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = blue, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = blue, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = blue, bold = true, underline = true })

vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = fgg })

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = orange })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = fgg })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "@punctuation" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = lightblue, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = fgg })

vim.api.nvim_set_hl(0, "@conceal.markdown_inline", { fg = fggg })

vim.api.nvim_set_hl(0, "@markup.strong.latex", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.latex", { italic = true })

vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

vim.api.nvim_set_hl(0, "@markup.link.gitcommit", { link = "Type" })
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = green })

vim.api.nvim_set_hl(0, "@function.make", { fg = green })
vim.api.nvim_set_hl(0, "@function.cmake", { fg = green })
vim.api.nvim_set_hl(0, "@function.latex", { fg = green })

vim.api.nvim_set_hl(0, "@keyword.import.latex", { fg = orange })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = red })

vim.api.nvim_set_hl(0, "@punctuation.delimiter.comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@comment.todo.comment", { bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.note.comment", { bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.warning.comment", { fg = green, bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.error.comment", { fg = orange, bg = bggggg, bold = true })

vim.api.nvim_set_hl(0, "@tag", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "@tag.builtin", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "@punctuation" })

vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@tag.css", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })

vim.api.nvim_set_hl(0, "@lsp.type.bracket", { link = "@punctuation" })

vim.api.nvim_set_hl(0, "IblScope", { fg = bggggg })
vim.api.nvim_set_hl(0, "IblIndent", { fg = bggggg })

vim.api.nvim_set_hl(0, "@string.documentation.python", { link = "Comment" })

vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })

vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = red })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = fggg })

vim.api.nvim_set_hl(0, "CmpItemKind", { fg = fgg })

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = purple })

vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "Type" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "Type" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "Type" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { link = "Type" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { link = "Type" })

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "PreProc" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = red })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "Comment" })
vim.api.nvim_set_hl(0, "CmpItemKindField", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = green })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { link = "Function" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "Function" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { link = "Constant" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "Constant" })

vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = bgg })
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = fg })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = bggggg })
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = orange })
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = red })

vim.api.nvim_set_hl(0, "TroubleNormal", { link = "NeoTreeNormal" })
vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NeoTreeNormalNC" })
vim.api.nvim_set_hl(0, "TroubleIndent", { fg = bggggg })

vim.api.nvim_set_hl(0, "TreesitterContext", { bg = bgggg })

vim.api.nvim_set_hl(0, "@string.escape", { fg = blue })
vim.api.nvim_set_hl(0, "@character.printf", { fg = orange })
vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier", { fg = orange })
vim.api.nvim_set_hl(0, "@character.special", { fg = fggg })
