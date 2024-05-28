---@type LazySpec
return {
  { "goolord/alpha-nvim", opts = function(_, opts) opts.section.header.val = {} end },

  { "max397574/better-escape.nvim" },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  { "bkad/CamelCaseMotion", lazy = false },
  { "guns/vim-sexp", ft = { "clojure" }, config = function() vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0) end, },
  { "Wansmer/treesj", dependencies = { "nvim-treesitter/nvim-treesitter" }, config = function() require("treesj").setup { use_default_keymaps = false } end, },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"

      opts.defaults.mappings.i["<C-n>"] = actions.move_selection_next
      opts.defaults.mappings.i["<C-p>"] = actions.move_selection_previous
      opts.defaults.mappings.i["<C-j>"] = actions.cycle_history_next
      opts.defaults.mappings.i["<C-k>"] = actions.cycle_history_prev
    end,
  },

  { "nvim-treesitter/nvim-treesitter" },
}
