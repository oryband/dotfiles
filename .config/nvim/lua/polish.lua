local opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "w", "<Plug>CamelCaseMotion_w", opts)
map("", "e", "<Plug>CamelCaseMotion_e", opts)
map("", "b", "<Plug>CamelCaseMotion_b", opts)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindDefault" })
