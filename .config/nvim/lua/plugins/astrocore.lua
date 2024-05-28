---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
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
