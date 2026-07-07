local opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "w", "<Plug>CamelCaseMotion_w", opts)
map("", "e", "<Plug>CamelCaseMotion_e", opts)
map("", "b", "<Plug>CamelCaseMotion_b", opts)

-- Don't dim any "hidden" item in neo-tree (dotfile, gitignored, or otherwise
-- filtered) -- everything hidden links to NeoTreeDotfile by default. fg only,
-- no bg, so it doesn't block the cursorline highlight underneath.
vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "fg" })
