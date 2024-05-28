---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = false,
      codelens = false,
    },
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
  },
}
