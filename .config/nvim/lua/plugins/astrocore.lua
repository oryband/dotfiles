---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        title = true,
        titlestring = "%t", -- Just show the tail (filename) instead of full path
      },
      g = {
        python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python"),
        loaded_node_provider = 0, -- Disable Node provider (not needed; Mason LSPs use node from PATH via polish.lua)
      },
    },
    features = {
      autopairs = false,
    },
    diagnostics = {
      virtual_text = false,
      underline = false,
    },
    mappings = {
      n = {
        ["<Leader>s"] = { "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
      },
    },
  },
}
