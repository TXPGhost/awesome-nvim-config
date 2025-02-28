local fg = "#d2c9bb"
local fgg = "#9e978c"
local fggg = "#757068"
local fgggg = "#6b665f"
local fggggg = "#514e48"

local bg = "#111111"
local bgg = "#151515"
local bggg = "#191919"
local bgggg = "#1d1d1d"
local bggggg = "#212121"
local bgggggg = "#252525"

local hl1 = "#d1b78e"
local hl2 = "#d1a764"
local hl3 = "#6293bb"
local hl4 = "#C64640"
local hl5 = "#8FB573"

local redbg = "#2C1F1D"
local greenbg = "#232C23"
local bluebg = "#1D2228"
local bluebgg = "#242b33"

-- terminal
vim.g.terminal_color_0 = fggg -- black
vim.g.terminal_color_1 = hl4 -- red
vim.g.terminal_color_2 = hl5 -- green
vim.g.terminal_color_3 = hl2 -- yellow
vim.g.terminal_color_4 = hl1 -- blue
vim.g.terminal_color_5 = hl3 -- magenta
vim.g.terminal_color_6 = hl2 -- cyan
vim.g.terminal_color_7 = fgg -- white
vim.g.terminal_color_8 = fggg -- black (bright)
vim.g.terminal_color_9 = hl4 -- red (bright)
vim.g.terminal_color_10 = hl5 -- green (bright)
vim.g.terminal_color_11 = hl2 -- yellow (bright)
vim.g.terminal_color_12 = hl1 -- blue (bright)
vim.g.terminal_color_13 = hl3 -- magenta (bright)
vim.g.terminal_color_14 = hl2 -- cyan (bright)
vim.g.terminal_color_15 = fgg -- white (bright)

vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bgg })
vim.api.nvim_set_hl(0, "Identifier", { fg = hl4 })
vim.api.nvim_set_hl(0, "Statement", {})
vim.api.nvim_set_hl(0, "Function", { fg = hl2 })
vim.api.nvim_set_hl(0, "Constant", { fg = hl4 })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = hl4 })
vim.api.nvim_set_hl(0, "Special", {})
vim.api.nvim_set_hl(0, "Operator", { fg = fgg })
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bggggg, fg = fgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggggg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bgggg })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = bgggg, fg = fggggg })
vim.api.nvim_set_hl(0, "Type", { fg = hl2 })
vim.api.nvim_set_hl(0, "PreProc", { fg = hl3 })
vim.api.nvim_set_hl(0, "String", { fg = hl3 })
vim.api.nvim_set_hl(0, "Character", { fg = hl3 })
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "FoldColumn", {})
vim.api.nvim_set_hl(0, "Directory", { fg = hl2 })
vim.api.nvim_set_hl(0, "ModeMsg", { fg = hl1, bold = true })
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
vim.api.nvim_set_hl(0, "Title", { fg = hl2 })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bggggg })
vim.api.nvim_set_hl(0, "Error", { fg = hl4, bg = redbg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = hl4, bg = redbg })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = hl3, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { fg = hl5, bg = greenbg })
vim.api.nvim_set_hl(0, "diffChanged", { fg = hl3, bg = bluebg })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = hl4, bg = redbg })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { bg = bluebgg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = hl5 })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = hl3 })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = hl4 })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = hl1 })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = hl2 })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = hl4 })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = hl1, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = hl2, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = hl4, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = fggg })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = hl1, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = hl2, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = hl4, italic = true })

vim.api.nvim_set_hl(0, "@punctuation", { fg = fgg })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fgg })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@keyword", { fg = hl1, italic = true })
vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@function", { fg = hl2 })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = hl2 })

vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = hl1 })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { fg = hl3 })

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

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = fg, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = fg, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = fg, bold = true, underline = true })

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = hl4 })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = fgg })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "@punctuation" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = fg, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = hl2, bold = true })
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = fgg })

vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = fgg })

vim.api.nvim_set_hl(0, "@markup.strong.latex", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.latex", { italic = true })

vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

vim.api.nvim_set_hl(0, "@markup.link.gitcommit", { link = "Type" })
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = hl2 })

vim.api.nvim_set_hl(0, "@function.make", { fg = hl2 })
vim.api.nvim_set_hl(0, "@function.cmake", { fg = hl2 })
vim.api.nvim_set_hl(0, "@function.latex", { fg = hl2 })

vim.api.nvim_set_hl(0, "@keyword.import.latex", { fg = hl4 })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = hl1 })

vim.api.nvim_set_hl(0, "@punctuation.delimiter.comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@comment.todo.comment", { bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.note.comment", { bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.warning.comment", { fg = hl2, bg = bggggg, bold = true })
vim.api.nvim_set_hl(0, "@comment.error.comment", { fg = hl4, bg = bggggg, bold = true })

vim.api.nvim_set_hl(0, "@function.call.rust", { fg = fg })

vim.api.nvim_set_hl(0, "@tag.html", { link = "Type" })
vim.api.nvim_set_hl(0, "@tag.xml", { link = "Type" })

vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@tag.css", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })

vim.api.nvim_set_hl(0, "@lsp.type.bracket", { link = "@punctuation" })

vim.api.nvim_set_hl(0, "@string.documentation.python", { link = "Comment" })

vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })

vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = hl1 })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = fggg })

vim.api.nvim_set_hl(0, "CmpItemKind", { fg = fgg })

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = hl5 })

vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = hl2 })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = hl2 })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = hl2 })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = hl2 })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = hl2 })

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = hl4 })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = hl1 })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fggg })
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = hl1 })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fg })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = hl2 })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = hl2 })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = hl4 })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = hl4 })

vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { bg = bg })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = bgg })
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = fg })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = bggggg })
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = hl5 })
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = hl4 })

vim.api.nvim_set_hl(0, "TroubleNormal", { link = "NeoTreeNormal" })
vim.api.nvim_set_hl(0, "TroubleNormalNC", { link = "NeoTreeNormalNC" })
vim.api.nvim_set_hl(0, "TroubleIndent", { fg = bggggg })

vim.api.nvim_set_hl(0, "TreesitterContext", { bg = bgggg })

vim.api.nvim_set_hl(0, "@string.escape", { fg = hl1 })
vim.api.nvim_set_hl(0, "@character.printf", { fg = hl2 })
vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier", { fg = hl2 })
vim.api.nvim_set_hl(0, "@character.special", { fg = fggg })

vim.api.nvim_set_hl(0, "Terminal", { bg = bg })

vim.api.nvim_set_hl(0, "LspInlayHint", { fg = fggggg })
