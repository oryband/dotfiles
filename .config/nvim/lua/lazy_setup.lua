require("lazy").setup({
  { "AstroNvim/AstroNvim", version = "^6", import = "astronvim.plugins", },
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  performance = { rtp = { disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", }, },
  },
} --[[@as LazyConfig]])
