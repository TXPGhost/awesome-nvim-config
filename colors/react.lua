-- colors inspired from https://react.dev/blog/2024/04/25/react-19

local fg = "#FFFFFF"
local fgg = "#AAB1C1"
local fggg = "#60697F"
local fgggg = "#434959"
local fggggg = "#343944"

local bg = "#16181D"
local bgg = "#191B21"
local bggg = "#1D1F26"
local bgggg = "#20232B"

local keyword = "#77B7D7"
local func = "#86D9CA"
local string = "#977CDC"
local constant = "#C64640"
local type = "#DFAB5C"
local green = "#8FB573"

local redbg = "#2C2020"
local greenbg = "#20252C"
local bluebg = "#20202C"
local bluebgg = "#252545"

-- terminal
vim.g.terminal_color_0 = fggg     -- black
vim.g.terminal_color_1 = constant -- red
vim.g.terminal_color_2 = green    -- green
vim.g.terminal_color_3 = type     -- yellow
vim.g.terminal_color_4 = keyword  -- blue
vim.g.terminal_color_5 = string   -- magenta
vim.g.terminal_color_6 = func     -- cyan
vim.g.terminal_color_7 = fgg      -- white
vim.g.terminal_color_8 = fggg     -- black (bright)
vim.g.terminal_color_9 = constant -- red (bright)
vim.g.terminal_color_10 = green   -- green (bright)
vim.g.terminal_color_11 = type    -- yellow (bright)
vim.g.terminal_color_12 = keyword -- blue (bright)
vim.g.terminal_color_13 = string  -- magenta (bright)
vim.g.terminal_color_14 = func    -- cyan (bright)
vim.g.terminal_color_15 = fgg     -- white (bright)

if vim.g.neovide then
	vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
else
	vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
end

vim.api.nvim_set_hl(0, "Identifier", { fg = constant })
vim.api.nvim_set_hl(0, "Statement", {})
vim.api.nvim_set_hl(0, "Function", { fg = func })
vim.api.nvim_set_hl(0, "Constant", { fg = constant })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = constant })
vim.api.nvim_set_hl(0, "Special", {})
vim.api.nvim_set_hl(0, "Operator", { fg = fgg })
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bgg })
vim.api.nvim_set_hl(0, "Type", { fg = type })
vim.api.nvim_set_hl(0, "PreProc", { fg = string })
vim.api.nvim_set_hl(0, "String", { fg = string })
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "FoldColumn", {})
vim.api.nvim_set_hl(0, "Directory", { fg = func })
vim.api.nvim_set_hl(0, "ModeMsg", { fg = keyword, bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = fgggg })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fggggg })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fggggg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = fggggg })
vim.api.nvim_set_hl(0, "CursorLine", { bg = bgg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fgggg })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fgg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bgggg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bggg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bgg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bggg })
vim.api.nvim_set_hl(0, "Visual", { bg = bggg })
vim.api.nvim_set_hl(0, "Search", { reverse = true })
vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bgg })
vim.api.nvim_set_hl(0, "Title", { fg = func })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bggg })
vim.api.nvim_set_hl(0, "Error", { fg = constant, bg = redbg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = constant, bg = redbg })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = string, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { bg = greenbg })
vim.api.nvim_set_hl(0, "diffChanged", { bg = bluebg })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = constant, bg = redbg })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { bg = bluebgg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = func })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = keyword })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = constant })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = fg })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = keyword })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = type })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = constant })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = keyword, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = type, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = constant, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = fggg })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = fg, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = keyword, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = type, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = constant, italic = true })

vim.api.nvim_set_hl(0, "@punctuation", { fg = fgg })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fgg })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@keyword", { fg = keyword, italic = true })
vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@function", { fg = func })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = func })

vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = keyword })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
-- vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { fg = string })

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

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = string, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = string, bold = true })

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = fggg })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = constant })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = string })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "@punctuation" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = fg, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = func, bold = true })

vim.api.nvim_set_hl(0, "@markup.strong.latex", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.latex", { italic = true })

vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

vim.api.nvim_set_hl(0, "@markup.link.gitcommit", { link = "Type" })
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = func })

vim.api.nvim_set_hl(0, "@function.make", { fg = func })
vim.api.nvim_set_hl(0, "@function.cmake", { fg = func })
vim.api.nvim_set_hl(0, "@function.latex", { fg = fg })

vim.api.nvim_set_hl(0, "@comment.todo.comment", { bg = bggg, bold = true })

vim.api.nvim_set_hl(0, "@function.call.rust", { fg = fg })

vim.api.nvim_set_hl(0, "@tag.html", { link = "Type" })
vim.api.nvim_set_hl(0, "@tag.xml", { link = "Type" })

vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@tag.css", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })

vim.api.nvim_set_hl(0, "@lsp.type.bracket", { link = "@punctuation" })

vim.api.nvim_set_hl(0, "CmpItemKind", { fg = fgg })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKind" })

vim.api.nvim_set_hl(0, "IblScope", { fg = bggg })
vim.api.nvim_set_hl(0, "IblIndent", { fg = bggg })

vim.api.nvim_set_hl(0, "@string.documentation.python", { link = "Comment" })

vim.api.nvim_set_hl(0, "ObsidianRefText", { fg = string, bold = true, underline = true })
vim.api.nvim_set_hl(0, "ObsidianBullet", { fg = fggg, bold = false })
vim.api.nvim_set_hl(0, "ObsidianTodo", { fg = fggg, bold = false })
vim.api.nvim_set_hl(0, "ObsidianDone", { fg = keyword, bold = false })
vim.api.nvim_set_hl(0, "ObsidianRightArrow", { fg = type, bold = false })
vim.api.nvim_set_hl(0, "ObsidianTilde", { fg = constant, bold = false })
vim.api.nvim_set_hl(0, "ObsidianExtLinkIcon", { fg = string, bold = false })
