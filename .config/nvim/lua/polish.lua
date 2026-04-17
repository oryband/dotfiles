-- Make nvm's default node available on PATH for Mason/LSP servers
-- (zsh lazy-loads nvm, so $PATH wouldn't otherwise contain it when nvim launches)
local nvm_default_file = vim.env.HOME .. "/.nvm/alias/default"
local file = io.open(nvm_default_file, "r")
if file then
  local nvm_default_version = file:read("*line")
  file:close()
  if nvm_default_version then
    local node_bin = vim.env.HOME .. "/.nvm/versions/node/v" .. nvm_default_version .. "/bin"
    vim.env.PATH = node_bin .. ":" .. vim.env.PATH
  end
end

local opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "w", "<Plug>CamelCaseMotion_w", opts)
map("", "e", "<Plug>CamelCaseMotion_e", opts)
map("", "b", "<Plug>CamelCaseMotion_b", opts)
