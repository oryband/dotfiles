---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { "smartcolumn.nvim", opts = { scope = "line", custom_colorcolumn = { python = { 79 }, clojure = { 120 }, gitcommit = { 50, 72 } } }, },
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
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
  { import = "astrocommunity.code-runner.molten-nvim" },
  { import = "astrocommunity.pack.quarto" },
  -- Override treesitter config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Exclude latex (requires grammar generation, incompatible with tree-sitter CLI 0.26+)
      if opts.ensure_installed and type(opts.ensure_installed) == "table" then
        opts.ensure_installed = vim.tbl_filter(function(parser)
          return parser ~= "latex"
        end, opts.ensure_installed)
      end
    end,
  },
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

  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
}
