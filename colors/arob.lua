-- colorscheme
local fg = "#A7AAB0"
local fgg = "#76787C"
local fggg = "#5e6063"
local fgggg = "#464749"
local fggggg = "#2e2f30"

local bg = "#121212"
local bgg = "#151515"
local bggg = "#181818"
local bgggg = "#1A1A1A"

local blue = "#466793"
local lightblue = "#839BAF"
local cyan = "#568FA5"
local green = "#56A56B"
local gold = "#BC9636"
local purple = "#9e5fcc"
local red = "#C6706F"

local redbg = "#1C1212"
local greenbg = "#121C12"
local bluebg = "#12121C"
local bluebgg = "#17172B"

vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = bg })
vim.api.nvim_set_hl(0, "Identifier", {})
vim.api.nvim_set_hl(0, "Statement", {})
vim.api.nvim_set_hl(0, "Constant", { fg = gold })
vim.api.nvim_set_hl(0, "Special", {})
vim.api.nvim_set_hl(0, "Comment", { fg = fggg, italic = true })
vim.api.nvim_set_hl(0, "Conceal", { fg = fgg })
vim.api.nvim_set_hl(0, "Pmenu", { bg = bgg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = bgggg })
vim.api.nvim_set_hl(0, "Type", { fg = cyan })
vim.api.nvim_set_hl(0, "PreProc", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "String", { fg = green })
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "FoldColumn", {})
vim.api.nvim_set_hl(0, "Directory", { fg = cyan })
vim.api.nvim_set_hl(0, "LineNr", { fg = fggg })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = fgggg })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = fgggg })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = fggggg })
vim.api.nvim_set_hl(0, "StatusLine", { fg = fggg, bg = bggg })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = fggg, bg = bgg })
vim.api.nvim_set_hl(0, "MsgArea", { fg = fgg, bg = bggg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bgggg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bggg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bgg })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = bggg })
vim.api.nvim_set_hl(0, "Visual", { bg = bggg })
vim.api.nvim_set_hl(0, "Search", { reverse = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = bgg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fggg })
vim.api.nvim_set_hl(0, "Folded", { fg = fggg, bg = bgg })
vim.api.nvim_set_hl(0, "Title", { fg = cyan, bold = true })
vim.api.nvim_set_hl(0, "MatchParen", { bg = bggg, bold = true })
vim.api.nvim_set_hl(0, "Error", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "NonText", { fg = fggg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = green, bold = true })

vim.api.nvim_set_hl(0, "diffAdded", { fg = green, bg = greenbg })
vim.api.nvim_set_hl(0, "diffChanged", { fg = blue, bg = bluebg })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = red, bg = redbg })
vim.api.nvim_set_hl(0, "diffLine", { fg = fggg })

vim.api.nvim_set_hl(0, "DiffAdd", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "diffChanged" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "diffRemoved" })
vim.api.nvim_set_hl(0, "DiffText", { fg = blue, bg = bluebgg })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = blue })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "diffAdded" })
vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "diffRemoved" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = gold, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = red, undercurl = true })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { sp = fggg, undercurl = true })

vim.api.nvim_set_hl(0, "@punctuation", { fg = fgg })
vim.api.nvim_set_hl(0, "@operator", { fg = fgg })
vim.api.nvim_set_hl(0, "@keyword", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "@keyword.directive", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "@keyword.import", { fg = purple, bold = true })

vim.api.nvim_set_hl(0, "@variable.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter", { italic = true })

vim.api.nvim_set_hl(0, "@variable.member", { fg = lightblue })
vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@function.method.call", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.typemod.property", { link = "@variable.member" })

vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable.member" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })

vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })

vim.api.nvim_set_hl(0, "@function.macro", { fg = purple, bold = true })

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

vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = lightblue })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = cyan })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = cyan })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = cyan })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = cyan })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = cyan })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = cyan })

vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = blue })
vim.api.nvim_set_hl(0, "@markup.math.latex", { fg = gold })
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = green })

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "Punctuation" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = lightblue, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = cyan, bold = true })

vim.api.nvim_set_hl(0, "@module.latex", { link = "Type" })

vim.api.nvim_set_hl(0, "fugitiveSymbolicRef", { link = "Directory" })
vim.api.nvim_set_hl(0, "fugitiveHelpTag", { link = "Character" })

vim.api.nvim_set_hl(0, "@markup.link.gitcommit", { link = "Type" })
vim.api.nvim_set_hl(0, "@string.special.url.gitcommit", { fg = fg })

vim.api.nvim_set_hl(0, "tutorSectionBullet", { fg = cyan })

vim.api.nvim_set_hl(0, "@function.make", { fg = cyan })
vim.api.nvim_set_hl(0, "@function.cmake", { fg = cyan })
vim.api.nvim_set_hl(0, "@function.latex", { fg = lightblue })

vim.api.nvim_set_hl(0, "@comment.todo.comment", { bg = bggg, bold = true })

vim.api.nvim_set_hl(0, "@function.call.rust", { fg = fg })

vim.api.nvim_set_hl(0, "@tag.html", { link = "Type" })
vim.api.nvim_set_hl(0, "@tag.xml", { link = "Type" })

vim.api.nvim_set_hl(0, "@attribute.gdscript", { link = "PreProc" })
