---@type LazySpec
return {
  { "goolord/alpha-nvim", opts = function(_, opts) opts.section.header.val = {} end },

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
  { "nvim-treesitter/playground", lazy = false, dependencies = { "nvim-treesitter/nvim-treesitter" } },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function() require("copilot_cmp").setup {} end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "copilot", priority = 1000 },
        { name = "nvim_lsp", priority = 800 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }
      return opts
    end,
  },

  {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        Copilot = "",
      },
    },
  },
}
