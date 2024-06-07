local fg = "#F4EDF7"
local fgg = "#86838A"
local fggg = "#606060"
local fgggg = "#505050"
local fggggg = "#404040"

local bg = "#202020"
local bgg = "#232323"
local bggg = "#262626"
local bgggg = "#292929"

local keyword = "#4ED0E1"
local operator = "#FA608C"
local func = "#7AD78F"
local string = "#FBE466"
local constant = "#9188E2"
local argument = "#FB9152"
local purple = "#cd70e5"
local red = "#d84e4b"

local redbg = "#2C2020"
local greenbg = "#202C20"
local bluebg = "#20202C"
local bluebgg = "#252545"

-- terminal
vim.g.terminal_color_0 = "#101012"  -- black
vim.g.terminal_color_1 = "#DE5D68"  -- red
vim.g.terminal_color_2 = "#8FB573"  -- green
vim.g.terminal_color_3 = "#DBB671"  -- yellow
vim.g.terminal_color_4 = "#57A5E5"  -- blue
vim.g.terminal_color_5 = "#BB70D2"  -- magenta
vim.g.terminal_color_6 = "#51A8B3"  -- cyan
vim.g.terminal_color_7 = "#A7AAB0"  -- white
vim.g.terminal_color_8 = "#5A5B5E"  -- black (bright)
vim.g.terminal_color_9 = "#DE5D68"  -- red (bright)
vim.g.terminal_color_10 = "#8FB573" -- green (bright)
vim.g.terminal_color_11 = "#DBB671" -- yellow (bright)
vim.g.terminal_color_12 = "#57A5E5" -- blue (bright)
vim.g.terminal_color_13 = "#BB70D2" -- magenta (bright)
vim.g.terminal_color_14 = "#51A8B3" -- cyan (bright)
vim.g.terminal_color_15 = "#A7AAB0" -- white (bright)

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
vim.api.nvim_set_hl(0, "Operator", { fg = operator })
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bgg })
vim.api.nvim_set_hl(0, "Type", { fg = fg })
vim.api.nvim_set_hl(0, "PreProc", { fg = purple })
vim.api.nvim_set_hl(0, "String", { fg = string })
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "FoldColumn", {})
vim.api.nvim_set_hl(0, "Directory", { fg = func })
vim.api.nvim_set_hl(0, "LineNr", { fg = fggg })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fgggg })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fgggg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = fggggg })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fgg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bgggg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bggg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bgg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bggg })
vim.api.nvim_set_hl(0, "Visual", { bg = bggg })
vim.api.nvim_set_hl(0, "Search", { reverse = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = bgg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fggg })
vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bgg })
vim.api.nvim_set_hl(0, "Title", { fg = func })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bggg })
vim.api.nvim_set_hl(0, "Error", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = string, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { fg = string, bg = greenbg })
vim.api.nvim_set_hl(0, "diffChanged", { fg = keyword, bg = bluebg })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { fg = keyword, bg = bluebgg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = string })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = keyword })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = fg, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = func, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = constant, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = red, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { sp = fggg, undercurl = true })

vim.api.nvim_set_hl(0, "@punctuation", { fg = fgg })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fgg })
vim.api.nvim_set_hl(0, "@operator", { fg = operator })
vim.api.nvim_set_hl(0, "@keyword", { fg = keyword, italic = true })
vim.api.nvim_set_hl(0, "@keyword.directive", { fg = purple })
vim.api.nvim_set_hl(0, "@keyword.import", { fg = purple })
vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@function", { fg = func })

vim.api.nvim_set_hl(0, "@variable.parameter", { fg = argument, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = argument, italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { fg = argument, italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = fg })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
-- vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@keyword" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { fg = purple })

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

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = func })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = func })

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = keyword })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = constant })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = string })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "Punctuation" })
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

vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })

vim.api.nvim_set_hl(0, "OilGitStatusIndexUnmodified", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexIgnored", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexUntracked", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexAdded", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexCopied", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexDeleted", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexModified", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexRenamed", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexTypeChanged", { link = "Constant" })
vim.api.nvim_set_hl(0, "OilGitStatusIndexUnmerged", { link = "Constant" })

vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeUnmodified", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeIgnored", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeUntracked", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeAdded", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeCopied", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeDeleted", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeModified", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeRenamed", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeTypeChanged", { link = "Title" })
vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeUnmerged", { link = "Title" })

vim.api.nvim_set_hl(0, "@lsp.type.bracket", { link = "@punctuation" })

vim.api.nvim_set_hl(0, "CmpItemKind", { fg = fgg })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKind" })

vim.api.nvim_set_hl(0, "IblScope", { fg = bggg })
vim.api.nvim_set_hl(0, "IblIndent", { fg = bggg })
