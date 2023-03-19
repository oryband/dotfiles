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

    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },

    { "guns/vim-sexp", ft = { "clojure" }, config = function() vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0) end, },
    -- { "Olical/conjure", ft = { "clojure" } },

    { "nvim-treesitter/nvim-treesitter", ensure_installed = { "clojure", "lua", "markdown", "python" } },
    { "nvim-treesitter/playground", lazy = false},
    { "williamboman/mason-lspconfig.nvim", ensure_installed = { "clojure_lsp", "lua_language_server" } },
    { "jay-babu/mason-null-ls.nvim", ensure_installed = { "black", "jq", "stylua", "zprint" } },
    { "jose-elias-alvarez/null-ls.nvim", config = function(config) local null_ls = require "null-ls" ; config.sources = { null_ls.builtins.formatting.zprint } ; return config end },
    { "jay-babu/mason-nvim-dap.nvim", ensure_installed = { "python" } },
  },
}
