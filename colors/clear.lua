-- clear all
for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
	local existing = vim.api.nvim_get_hl(0, { name = hl })
	vim.api.nvim_set_hl(0, hl, { link = existing.link })
end
