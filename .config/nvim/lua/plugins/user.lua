---@type LazySpec
return {
  -- Hide the dashboard ASCII header
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { preset = { header = "" } },
      picker = {
        win = {
          input = {
            keys = {
              ["<C-n>"] = { "list_down",       mode = { "i", "n" } },
              ["<C-p>"] = { "list_up",         mode = { "i", "n" } },
              ["<C-j>"] = { "history_forward", mode = { "i", "n" } },
              ["<C-k>"] = { "history_back",    mode = { "i", "n" } },
            },
          },
        },
        sources = {
          buffers = {
            win = {
              input = { keys = { ["<C-d>"] = { "bufdelete", mode = { "i", "n" } } } },
              list  = { keys = { ["dd"]    = "bufdelete" } },
            },
          },
        },
      },
    },
  },

  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },

  { "max397574/better-escape.nvim" },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  { "bkad/CamelCaseMotion", lazy = false },
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    opts = {
      view = {
        display_mode = "border",
      },
    },
  },
  { "Wansmer/treesj", dependencies = { "nvim-treesitter/nvim-treesitter" }, config = function() require("treesj").setup { use_default_keymaps = false } end, },
}
