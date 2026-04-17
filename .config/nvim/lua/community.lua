---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { "smartcolumn.nvim", opts = { scope = "line", custom_colorcolumn = { python = { 79 }, gitcommit = { 50, 72 } } }, },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.editing-support.nvim-devdocs" },
  {
    "nvim-devdocs",
    opts = function(_, opts)
      opts.previewer_cmd = nil
      opts.picker_cmd = false
      opts.wrap = true
      opts.ensure_installed = {
        "bash",
        "git",
        "jq",
        "kubectl",
        "markdown",
      }
    end,
  },
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.pack.bash" },
  -- { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.code-runner.molten-nvim" },
  { import = "astrocommunity.pack.quarto" },
  -- Render markdown in-editor (headings, lists, code blocks, etc.)
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  {
    "render-markdown.nvim",
    opts = {
      code = {
        border = "none", -- Don't hide closing ``` (molten-nvim compatibility)
        style = "language", -- Only show language icon, no background
      },
      heading = {
        backgrounds = {}, -- Disable heading backgrounds (too bright)
      },
    },
  },

  { import = "astrocommunity.recipes.picker-lsp-mappings" },
}
