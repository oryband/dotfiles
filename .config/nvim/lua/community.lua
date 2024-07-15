---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { "smartcolumn.nvim", opts = { scope = "line", custom_colorcolumn = { python = { 79 }, clojure = { 120 }, gitcommit = { 50, 72 } } }, },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.completion.copilot-cmp" },
  { import = "astrocommunity.editing-support.nvim-devdocs" },
  {
    "nvim-devdocs",
    opts = function(_, opts)
      opts.previewer_cmd = nil
      opts.picker_cmd = false
      opts.wrap = true
      opts.ensure_installed = { "python-3.10", "clojure-1.11", "docker", "bash", "markdown" }
    end,
  },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.clojure" },
  { "gpanders/nvim-parinfer", enabled = false },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
}
