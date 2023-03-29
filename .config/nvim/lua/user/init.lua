return {
  colorscheme = "dracula",
  opt = {
    termguicolors = true,
  },
  g = {
    maplocalleader = ",",
    autopairs_enabled = false,
  },
  diagnostics = {
    virtual_text = false,
    underline = false,
  },
  lsp = {
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
  },
  plugins = {
    { "dracula/vim", name = "dracula" },
    { "goolord/alpha-nvim", opts = function(_, opts) opts.section.header.val = {} end },
    { "tpope/vim-surround", lazy = false },
    { "tpope/vim-repeat", lazy = false },
    { "bkad/CamelCaseMotion", lazy = false },

    { "guns/vim-sexp", ft = { "clojure" }, config = function() vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0) end },
    -- { "Olical/conjure", ft = { "clojure" } },

    { "zbirenbaum/copilot.lua", config = function() require("copilot").setup { suggestion = { enabled = false }, panel = { enabled = false } } end, },
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
      dependencies = { "zbirenbaum/copilot.lua", },
      config = function() require("copilot_cmp").setup { formatters = { insert_text = require("copilot_cmp.format").remove_existing } } end,
    },

    { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "clojure", "lua", "markdown", "python" } } },
    { "nvim-treesitter/playground", dependencies = { "nvim-treesitter/nvim-treesitter" } },
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "clojure_lsp", "lua_ls" } } },
    { "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = { "black", "jq", "stylua", "zprint" } } },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "jay-babu/mason-nvim-dap.nvim", ensure_installed = { "python" } },

    {
      "hrsh7th/nvim-cmp",
      dependencies = { "zbirenbaum/copilot-cmp" },
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "copilot", priority = 1000 },
          { name = "nvim_lsp", priority = 900 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }
        return opts
      end,
    },
  },
  polish = function()
    local opts = { silent = true }
    local map = vim.api.nvim_set_keymap

    map("", "w", "<Plug>CamelCaseMotion_w", opts)
    map("", "e", "<Plug>CamelCaseMotion_e", opts)
    map("", "b", "<Plug>CamelCaseMotion_b", opts)
  end,
}
