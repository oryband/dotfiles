-- Pin neovim to nvm default node version for LSP servers
-- This keeps zsh lazy-loading fast while making node available to Mason/LSP
-- Source: https://jaketrent.com/post/set-node-version-nvim/
local home_dir = vim.env.HOME
local nvm_default_file = home_dir .. "/.nvm/alias/default"

-- Read nvm default version dynamically
local nvm_default_version = nil
local file = io.open(nvm_default_file, "r")
if file then
  nvm_default_version = file:read("*line")
  file:close()
end

if nvm_default_version then
  local node_bin = home_dir .. "/.nvm/versions/node/v" .. nvm_default_version .. "/bin"
  vim.g.node_host_prog = node_bin .. "/node"
  vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")
end

local opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "w", "<Plug>CamelCaseMotion_w", opts)
map("", "e", "<Plug>CamelCaseMotion_e", opts)
map("", "b", "<Plug>CamelCaseMotion_b", opts)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindDefault" })
